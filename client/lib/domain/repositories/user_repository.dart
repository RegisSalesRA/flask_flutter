import 'package:client/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<List<UserEntity>> getUserFromDatasource();

  Future<void> postUserDatasource(data);

  Future<void> deleteUserDataSource(id);

  Future<void> updateUserDataSource(data);

  Future<List<UserEntity>> getuserfilterbygroupdatasource(data);
}
