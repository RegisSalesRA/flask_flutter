import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final int id;
  final String name;

  const GroupEntity({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
