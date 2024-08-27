import 'package:bloc/bloc.dart';
import 'package:client/domain/usecases/user_usercases.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/user_model.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUser>(_onAddUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await userUseCases.getusers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      try {
        await userUseCases.postusers(event.user);
        final updatedUsers = List.of((state as UserLoaded).users)
          ..add(event.user);
        emit(UserLoaded(updatedUsers));
      } catch (e) {
        emit(_handleError(e));
      }
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      try {
        await userUseCases.updateusers(event.user);
        final updatedUsers = (state as UserLoaded).users.map((user) {
          return user.id == event.user.id ? event.user : user;
        }).toList();
        emit(UserLoaded(updatedUsers));
      } catch (e) {
        emit(_handleError(e));
      }
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      try {
        await userUseCases.deleteusers(event.id);
        final updatedUsers = (state as UserLoaded)
            .users
            .where((user) => user.id != event.id)
            .toList();
        emit(UserLoaded(updatedUsers));
      } catch (e) {
        emit(_handleError(e));
      }
    }
  }

  UserError _handleError(dynamic e) {
    if (e is NetworkException) {
      return UserError("Network Error: ${e.message}");
    } else if (e is TimeoutException) {
      return UserError("Request timed out. Please try again.");
    } else {
      return UserError("Unexpected error occurred: ${e.toString()}");
    }
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException([this.message = 'Request timed out']);

  @override
  String toString() => message;
}
