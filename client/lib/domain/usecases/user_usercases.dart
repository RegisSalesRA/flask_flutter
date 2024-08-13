import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/repositories/user_repository.dart';

class UserUseCases {
  UserUseCases({required this.userRepo});
  final UserRepo userRepo;

  Future<List<UserEntity>> getusers() async {
    return userRepo.getUserFromDatasource();
  }
}
