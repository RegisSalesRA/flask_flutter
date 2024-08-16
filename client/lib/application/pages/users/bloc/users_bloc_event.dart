part of 'users_bloc_bloc.dart';

sealed class UsersBlocEvent extends Equatable {
  const UsersBlocEvent();

  @override
  List<Object> get props => [];
}

class UserRequestedEvent extends UsersBlocEvent {}

class UserPostRequestedEvent extends UsersBlocEvent {
  final UserEntity user;

  const UserPostRequestedEvent({required this.user});

  @override
  List<Object> get props => [user];
}
