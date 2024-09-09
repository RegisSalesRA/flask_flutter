import 'dart:convert';
import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late UserRemoteDatasourceImpl datasource;

  setUp(() {
    mockClient = MockHttpClient();
    datasource = UserRemoteDatasourceImpl(client: mockClient);
  });

  group('UserRemoteDatasourceImpl', () {
    test('should retrieve user list when request is 200', () async {
      when(() => mockClient.get(
            Uri.parse('http://10.0.2.2:5000/users'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer((_) async => http.Response(
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
            headers: {'content-type': 'application/json'},
          ));

      final users = await datasource.getUserFromApi();

      expect(users.length, equals(2));
      expect(users[0].firstName, equals('John 2'));
      expect(users[0].group['name'], equals('grupo1'));
    });

    test('should throw exception when request fails with 404', () async {
      when(() => mockClient.get(
            Uri.parse('http://10.0.2.2:5000/users'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => datasource.getUserFromApi(), throwsA(isA<Exception>()));
    });

    test('should post user and return status 201', () async {
      final user = UserModel(
        id: 0,
        email: 'test@example.com',
        firstName: 'Test',
        group: const {"id": 1, "name": "grupo1"},
      );

      when(() => mockClient.post(
                Uri.parse('http://10.0.2.2:5000/create_user'),
                body: jsonEncode({
                  "firstName": user.firstName,
                  "email": user.email,
                  "groupId": user.group['id']
                }),
                headers: {'Content-Type': 'application/json'},
              ))
          .thenAnswer(
              (_) async => http.Response('{"message": "User created!"}', 201));

      await datasource.postUserFromApi(user);

      verify(() => mockClient.post(
            Uri.parse('http://10.0.2.2:5000/create_user'),
            body: jsonEncode({
              "firstName": user.firstName,
              "email": user.email,
              "groupId": user.group['id']
            }),
            headers: {'Content-Type': 'application/json'},
          )).called(1);
    });

    test('should update user and return status 200', () async {
      final user = UserModel(
        id: 1,
        email: 'test@example.com',
        firstName: 'Test',
        group: const {"id": 1, "name": "grupo1"},
      );

      when(() => mockClient.patch(
                Uri.parse('http://10.0.2.2:5000/update_user/${user.id}'),
                body: jsonEncode({
                  "firstName": user.firstName,
                  "email": user.email,
                  "groupId": user.group['id']
                }),
                headers: {'Content-Type': 'application/json'},
              ))
          .thenAnswer(
              (_) async => http.Response('{"message": "User updated"}', 200));

      await datasource.updateUserFromApi(user);

      verify(() => mockClient.patch(
            Uri.parse('http://10.0.2.2:5000/update_user/${user.id}'),
            body: jsonEncode({
              "firstName": user.firstName,
              "email": user.email,
              "groupId": user.group['id']
            }),
            headers: {'Content-Type': 'application/json'},
          )).called(1);

      verifyNoMoreInteractions(mockClient);
    });

    test('should delete user and return status 200', () async {
      final user = UserModel(
        id: 1,
        email: 'test@example.com',
        firstName: 'Test',
        group: const {"id": 1, "name": "grupo1"},
      );

      when(() => mockClient.delete(
                Uri.parse('http://10.0.2.2:5000/delete_user/${user.id}'),
              ))
          .thenAnswer(
              (_) async => http.Response('{"message": "User deleted!"}', 200));

      await datasource.deleteUserFromApi(user.id);

      verify(() => mockClient.delete(
            Uri.parse('http://10.0.2.2:5000/delete_user/${user.id}'),
          )).called(1);
    });

    test('should filter users by group and return list when request is 200',
        () async {
      when(() => mockClient.get(
            Uri.parse(
                'http://10.0.2.2:5000/filter_users_by_group?groupName=teste'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer((_) async => http.Response(
            jsonEncode({
              "users": [
                {
                  "email": "john.doe2@example.com",
                  "firstName": "John updated",
                  "group": {"id": 1, "name": "teste"},
                  "id": 1
                }
              ]
            }),
            200,
            headers: {'content-type': 'application/json'},
          ));

      final users =
          await datasource.getuserfilterbygroupdatasourceFromApi('teste');

      expect(users[0].group['name'], equals('teste'));
    });
  });
}
