import 'dart:convert';
import 'package:client/data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDatasource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successfull
  /// throws a server-Exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final client = http.Client();

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        'accept': 'application/json ',
      },
    );
    final responseBody = json.decode(response.body);
    return AdviceModel.fromJson(responseBody);
  }
}
