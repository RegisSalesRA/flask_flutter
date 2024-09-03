import 'package:client/domain/entities/group_entity.dart';

abstract class GroupRepo {
  Future<List<GroupEntity>> getGroupFromDatasource();

  Future<void> postGroupDatasource(data);
}
