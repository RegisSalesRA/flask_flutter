import 'package:client/data/models/user_model.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('UserDatasource', () {
    group('should retrieve users list', () {
      test('when request is 200', () async {
        final mockClient = MockClient((request) async {
          if (request.url.toString() == 'http://10.0.2.2:5000/users') {
            return Response(
              jsonEncode({
                'users': [
                  {
                    'id': 1,
                    'firstName': 'John 2',
                    'email': 'john.doe2@example.com',
                    'group': {'id': 1, 'name': 'grupo1'},
                  },
                  {
                    'id': 2,
                    'firstName': 'User 2',
                    'email': 'user2@example.com',
                    'group': {'id': 2, 'name': 'Group 2'},
                  }
                ]
              }),
              200,
              headers: {'Content-Type': 'application/json'},
            );
          }
          return Response('Not Found', 404);
        });

        final response =
            await mockClient.get(Uri.parse('http://10.0.2.2:5000/users'));

        expect(response.statusCode, equals(200));

        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> usersJson = jsonResponse['users'];

        final List<UserModel> users =
            usersJson.map((userJson) => UserModel.fromJson(userJson)).toList();

        expect(users.length, equals(2));
        expect(users[0].firstName, equals('John 2'));
        expect(users[0].email, equals('john.doe2@example.com'));
        expect(users[0].group['name'], equals('grupo1'));

        expect(users[1].firstName, equals('User 2'));
        expect(users[1].email, equals('user2@example.com'));
        expect(users[1].group['name'], equals('Group 2'));
      });
    });
  });
}
