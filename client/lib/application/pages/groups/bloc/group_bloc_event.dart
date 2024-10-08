part of 'group_bloc.dart';

sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroups extends GroupEvent {}

class AddGroup extends GroupEvent {
  final GroupEntity group;

  const AddGroup(this.group);

  @override
  List<Object?> get props => [group];
}

class UpdateGroup extends GroupEvent {
  final GroupModel group;

  const UpdateGroup(this.group);

  @override
  List<Object?> get props => [group];
}

class DeleteGroup extends GroupEvent {
  final int id;

  const DeleteGroup(this.id);

  @override
  List<Object?> get props => [id];
}
