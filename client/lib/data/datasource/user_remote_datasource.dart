import 'dart:convert';
import 'package:client/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getRandomUserFromApi();
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
      print("aqui");
      return responseBody.map((json) => UserModel.fromJson(json)).toList();
    }
  }
}
