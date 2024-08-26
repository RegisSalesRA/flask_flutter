part of 'users_bloc_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final UserModel user;

  AddUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class DeletePost extends UserEvent {
  final int id;

  DeletePost(this.id);

  @override
  List<Object?> get props => [id];
}
