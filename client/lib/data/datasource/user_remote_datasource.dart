import 'dart:convert';
import 'package:client/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getRandomUserFromApi();
  Future<void> postUserFromApi(dynamic userModel);
  Future<void> updateUserFromApi(dynamic userModel);
  Future<void> deleteUserFromApi(int id);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  UserRemoteDatasourceImpl({required this.client});

  @override
  Future<List<UserModel>> getRandomUserFromApi() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:5000/contacts'),
      headers: {
        'content-type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      final List<dynamic> responseBody = json.decode(response.body)['contacts'];
      return responseBody.map((json) => UserModel.fromJson(json)).toList();
    }
  }

  @override
  Future<void> postUserFromApi(data) async {
    try {
      await client.post(
        Uri.parse('http://10.0.2.2:5000/create_contact'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": data.firstName,
          "lastName": data.lastName,
          "email": data.email,
          "groupId": data.group['groupId']
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> deleteUserFromApi(id) async {
    try {
      final response = await client
          .delete(Uri.parse('http://10.0.2.2:5000/delete_contact/$id'));
      if (response.statusCode != 200) {
        throw Exception("Failed to delete post");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> updateUserFromApi(data) async {
    try {
      final response = await client
          .patch(Uri.parse('http://10.0.2.2:5000/update_contact/$data'));
      if (response.statusCode != 200) {
        throw Exception("Failed to delete post");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
