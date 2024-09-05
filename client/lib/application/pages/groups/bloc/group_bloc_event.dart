part of 'group_bloc.dart';

sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroups extends GroupEvent {}

class AddGroup extends GroupEvent {
  final GroupModel group;

  AddGroup(this.group);

  @override
  List<Object?> get props => [group];
}

class UpdateGroup extends GroupEvent {
  final GroupModel group;

  UpdateGroup(this.group);

  @override
  List<Object?> get props => [group];
}

class DeleteGroup extends GroupEvent {
  final int id;

  DeleteGroup(this.id);

  @override
  List<Object?> get props => [id];
}
