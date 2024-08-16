import 'package:bloc/bloc.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/usecases/user_usercases.dart';

part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

class UsersBlocBloc extends Bloc<UsersBlocEvent, UsersBlocState> {
  final UserUseCases? userUseCases;

  UsersBlocBloc({required this.userUseCases}) : super(UsersBlocInitial()) {
    on<UserRequestedEvent>((event, emit) async {
      emit(UserStateLoading());

      try {
        final getUsers = await userUseCases!.getusers();
        emit(UserStateLoaded(user: getUsers));
      } catch (e) {
        emit(UserStateError(message: 'Failed to load users: $e'));
      }
    });

    on<UserPostRequestedEvent>((event, emit) async {
      emit(UserStateLoading());
      try {
        await userUseCases!.postusers(event.user);
        add(UserRequestedEvent());
      } catch (e) {
        emit(UserPostStateError(message: 'Failed to post user: $e'));
      }
    });
  }
}
