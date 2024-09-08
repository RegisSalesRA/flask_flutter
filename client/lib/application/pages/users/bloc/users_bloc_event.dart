part of 'users_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetUsers extends UserEvent {}

class PostUser extends UserEvent {
  final UserModel user;

  PostUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteUser extends UserEvent {
  final int id;

  DeleteUser(this.id);

  @override
  List<Object?> get props => [id];
}
