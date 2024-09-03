import 'package:client/domain/entities/group_entity.dart';
import 'package:client/domain/repositories/group_repository.dart';

class GroupUseCases {
  GroupUseCases({required this.groupRepo});
  final GroupRepo groupRepo;

  Future<List<GroupEntity>> getgroups() async {
    return groupRepo.getGroupFromDatasource();
  }

  Future<void> postgroups(data) async {
    return groupRepo.postGroupDatasource(data);
  }
}
