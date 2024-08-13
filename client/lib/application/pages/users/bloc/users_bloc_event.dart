part of 'users_bloc_bloc.dart';

sealed class UsersBlocEvent extends Equatable {
  const UsersBlocEvent();

  @override
  List<Object> get props => [];
}

class UserRequestedEvent extends UsersBlocEvent {}
