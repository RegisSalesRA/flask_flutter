import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/group_model.dart';

abstract class GroupRemoteDatasource {
  Future<List<GroupModel>> getGroupFromApi();
  Future<void> postGroupFromApi(dynamic userModel);
}

class GroupRemoteDatasourceImpl implements GroupRemoteDatasource {
  final http.Client client;
  GroupRemoteDatasourceImpl({required this.client});

  @override
  Future<List<GroupModel>> getGroupFromApi() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:5000/groups'),
      headers: {
        'content-type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      final List<dynamic> responseBody = json.decode(response.body)['groups'];
      return responseBody.map((json) => GroupModel.fromJson(json)).toList();
    }
  }

  @override
  Future<void> postGroupFromApi(data) async {
    try {
      await client.post(
        Uri.parse('http://10.0.2.2:5000/create_group'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": data.name,
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
