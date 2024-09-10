import 'package:bloc/bloc.dart';
import 'package:client/application/helpers/handler_erros_helper.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/usecases/user_usercase.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/user_model.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(UserStateInitial()) {
    on<GetUsers>(_onGetUsers);
    on<GetFilterUsers>(_onFilterUsersByGroup);
    on<PostUser>(_onPostUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onGetUsers(GetUsers event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    try {
      final users = await userUseCases.getusers();
      emit(UserStateLoaded(users));
    } catch (e) {
      emit(handleError(e));
    }
  }

  Future<void> _onPostUser(PostUser event, Emitter<UserState> emit) async {
    if (state is UserStateLoaded) {
      try {
        await userUseCases.postusers(event.user);
        final users = await userUseCases.getusers();
        emit(UserStateLoaded(users));
      } catch (e) {
        emit(handleError(e));
      }
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    if (state is UserStateLoaded) {
      try {
        await userUseCases.updateusers(event.user);
        final updatedUsers = (state as UserStateLoaded).users.map((user) {
          return user.id == event.user.id ? event.user : user;
        }).toList();
        emit(UserStateLoaded(updatedUsers));
      } catch (e) {
        emit(handleError(e));
      }
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    if (state is UserStateLoaded) {
      try {
        await userUseCases.deleteusers(event.id);
        final updatedUsers = (state as UserStateLoaded)
            .users
            .where((user) => user.id != event.id)
            .toList();
        emit(UserStateLoaded(updatedUsers));
      } catch (e) {
        emit(handleError(e));
      }
    }
  }

  Future<void> _onFilterUsersByGroup(
      GetFilterUsers event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    try {
      final users = await userUseCases.getuserfilterbygroup(event.name);
      print(users);
      emit(UserStateLoaded(users));
    } catch (e) {
      emit(handleError(e));
    }
  }
}
