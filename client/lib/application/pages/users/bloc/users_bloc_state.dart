part of 'users_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  final List<UserEntity> users;

  UserStateLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserStateError extends UserState {
  final String message;

  UserStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
