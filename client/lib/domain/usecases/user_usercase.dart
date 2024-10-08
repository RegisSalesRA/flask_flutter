import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/repositories/user_repository.dart';

class UserUseCases {
  UserUseCases({required this.userRepo});

  final UserRepo userRepo;

  Future<List<UserEntity>> getusers() async {
    return userRepo.getUserFromDatasource();
  }

  Future<void> postusers(data) async {
    return userRepo.postUserDatasource(data);
  }

  Future<void> deleteusers(id) async {
    return userRepo.deleteUserDataSource(id);
  }

  Future<void> updateusers(data) async {
    return userRepo.updateUserDataSource(data);
  }

  Future<List<UserEntity>> getuserfilterbygroup(data) async {
    return userRepo.getuserfilterbygroupdatasource(data);
  }
}
