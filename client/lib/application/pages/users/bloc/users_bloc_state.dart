part of 'users_bloc_bloc.dart';

sealed class UsersBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UsersBlocInitial extends UsersBlocState {}

final class UserStateLoading extends UsersBlocState {}

final class UserStateLoaded extends UsersBlocState {
  final dynamic user;
  UserStateLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

final class UserStateError extends UsersBlocState {
  final String message;
  UserStateError({required this.message});
  @override
  List<Object?> get props => [message];
}
