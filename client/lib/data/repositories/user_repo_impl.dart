import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/repositories/user_repository.dart';

class UserRepoImpl implements UserRepo {
  UserRepoImpl({required this.userRemoteDatasource});
  final UserRemoteDatasource userRemoteDatasource;

  @override
  Future<List<UserEntity>> getUserFromDatasource() async {
    try {
      return await userRemoteDatasource.getRandomUserFromApi();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> postUserDatasource(data) async {
    await userRemoteDatasource.postUserFromApi(data);
  }

  @override
  Future<void> deleteUserDataSource(id) async {
    await userRemoteDatasource.deleteUserFromApi(id);
  }

  @override
  Future<void> updateUserDataSource(id) async {
    await userRemoteDatasource.updateUserFromApi(id);
  }
}
