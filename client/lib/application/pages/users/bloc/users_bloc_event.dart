part of 'users_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetUsers extends UserEvent {}

class GetFilterUsers extends UserEvent {
  final String name;

  const GetFilterUsers(this.name);

  @override
  List<Object?> get props => [name];
}

class PostUser extends UserEvent {
  final UserModel user;

  const PostUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  const UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteUser extends UserEvent {
  final int id;

  const DeleteUser(this.id);

  @override
  List<Object?> get props => [id];
}
