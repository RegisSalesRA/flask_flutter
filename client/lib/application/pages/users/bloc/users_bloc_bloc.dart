import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/usecases/user_usercases.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases? userUseCases;

  UserBloc({this.userUseCases}) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final getUsers = await userUseCases!.getusers();
        emit(UserLoaded(getUsers));
      } catch (e) {
        emit(UserError('Failed to load users: $e'));
      }
    });

    on<AddUser>((event, emit) async {
      try {
        await userUseCases?.postusers(event.user);
        add(LoadUsers());
      } catch (e) {
        emit(UserError("Failed to add post"));
      }
    });

    on<UpdateUser>((event, emit) async {
      try {
        add(LoadUsers());
      } catch (e) {
        emit(UserError("Failed to update post"));
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        add(LoadUsers());
      } catch (e) {
        emit(UserError("Failed to delete post"));
      }
    });
  }
}
