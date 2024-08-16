part of 'users_bloc_bloc.dart';

abstract class UsersBlocState extends Equatable {
  const UsersBlocState();

  @override
  List<Object> get props => [];
}

class UsersBlocInitial extends UsersBlocState {}

class UserStateLoading extends UsersBlocState {}

class UserStateLoaded extends UsersBlocState {
  final List<UserEntity> user;

  const UserStateLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserStateError extends UsersBlocState {
  final String message;

  const UserStateError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserPostStateSuccess extends UsersBlocState {
  final UserEntity user;

  const UserPostStateSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UserPostStateError extends UsersBlocState {
  final String message;

  const UserPostStateError({required this.message});

  @override
  List<Object> get props => [message];
}
