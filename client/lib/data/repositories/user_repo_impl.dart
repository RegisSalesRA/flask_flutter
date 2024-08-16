import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/repositories/user_repository.dart';

class UserRepoImpl implements UserRepo {
  UserRepoImpl({required this.userRemoteDatasource});
  final UserRemoteDatasource userRemoteDatasource;

  @override
  Future<List<UserEntity>> getUserFromDatasource() async {
    try {
      final result = await userRemoteDatasource.getRandomUserFromApi();
      return result;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<void> postUserDatasource(data) async {
    await userRemoteDatasource.postUserFromApi(data);
  }
}
