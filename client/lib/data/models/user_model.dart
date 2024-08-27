import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.group,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      group: json['group'] as Map,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'group': group,
    };
  }
}
