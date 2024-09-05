import 'package:client/data/datasource/group_remote_datasource.dart';
import 'package:client/domain/entities/group_entity.dart';
import 'package:client/domain/repositories/group_repository.dart';
import 'package:flutter/material.dart';

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
    try {
      await groupRemoteDatasource.postGroupFromApi(data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
