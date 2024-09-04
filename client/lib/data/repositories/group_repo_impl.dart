import 'package:client/data/datasource/group_remote_datasource.dart'; 
import 'package:client/domain/entities/group_entity.dart'; 
import 'package:client/domain/repositories/group_repository.dart'; 

class GroupRepoImpl implements GroupRepo {
  GroupRepoImpl({required this.groupRemoteDatasource});
  final GroupRemoteDatasource groupRemoteDatasource;

  @override
  Future<List<GroupEntity>> getGroupFromDatasource() async {
    try {
      return await groupRemoteDatasource.getRandomGroupFromApi();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> postGroupDatasource(data) async {
    await groupRemoteDatasource.postGroupFromApi(data);
  }


}
