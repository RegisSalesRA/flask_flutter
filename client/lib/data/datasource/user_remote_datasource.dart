import 'dart:convert';
import 'package:client/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getRandomUserFromApi();
  Future<void> postUserFromApi(dynamic userModel);
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
  Future<void> postUserFromApi(dynamic userModel) async {
    print("POST CHAMANDO FINALMENTE!!");
    /**
     final response = await client.post(
      Uri.parse('http://10.0.2.2:5000/contacts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userModel.toJson()), // Converte o UserModel para JSON
    );

    if (response.statusCode != 201) {
      throw Exception("Falha ao criar o usuário. Código de status: ${response.statusCode}");
    } 
     */
  }
}
