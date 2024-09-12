import 'dart:convert';
import 'package:client/data/datasource/group_remote_datasource.dart';
import 'package:client/data/models/group_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late GroupRemoteDatasourceImpl datasource;

  setUp(() {
    mockClient = MockHttpClient();
    datasource = GroupRemoteDatasourceImpl(client: mockClient);
  });

  group('GroupRemoteDatasourceImpl', () {
    test('should retrieve group list when request is 200', () async {
      when(() => mockClient.get(
            Uri.parse('http://10.0.2.2:5000/groups'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer((_) async => http.Response(
            jsonEncode({
              'groups': [
                {
                  'id': 1,
                  'name': 'Group 1',
                },
                {
                  'id': 2,
                  'name': 'Group 2',
                }
              ]
            }),
            200,
            headers: {'content-type': 'application/json'},
          ));

      final groups = await datasource.getGroupFromApi();

      expect(groups.length, equals(2));
      expect(groups[0].name, equals('Group 1'));
      expect(groups[1].name, equals('Group 2'));
    });

    test('should throw exception when request fails with 404', () async {
      when(() => mockClient.get(
            Uri.parse('http://10.0.2.2:5000/groups'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => datasource.getGroupFromApi(), throwsA(isA<Exception>()));
    });

    test('should post group and return status 201', () async {
      final group = GroupModel(
        id: 0,
        name: 'Group 3',
      );

      when(() => mockClient.post(
                Uri.parse('http://10.0.2.2:5000/create_group'),
                body: jsonEncode({
                  "name": group.name,
                }),
                headers: {'Content-Type': 'application/json'},
              ))
          .thenAnswer(
              (_) async => http.Response('{"message": "Group created!"}', 201));

      await datasource.postGroupFromApi(group);

      verify(() => mockClient.post(
            Uri.parse('http://10.0.2.2:5000/create_group'),
            body: jsonEncode({
              "name": group.name,
            }),
            headers: {'Content-Type': 'application/json'},
          )).called(1);
    });
  });
}
