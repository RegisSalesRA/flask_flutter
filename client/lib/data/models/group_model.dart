import 'package:client/domain/entities/group_entity.dart';
import 'package:equatable/equatable.dart';


class GroupModel extends GroupEntity with EquatableMixin {
  GroupModel({
    required super.id,
    required super.name,
    
    
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'], 
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'name': name, 
    };
  }
}
