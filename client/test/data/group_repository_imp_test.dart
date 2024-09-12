import 'package:client/data/datasource/group_remote_datasource.dart';
import 'package:client/data/models/group_model.dart';
import 'package:client/data/repositories/group_repo_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGroupRemoteDatasource extends Mock implements GroupRemoteDatasource {}

void main() {
  group('GroupRepoImpl', () {
    late GroupRemoteDatasource mockGroupRemoteDatasource;
    late GroupRepoImpl groupRepoImplUnderTest;

    setUp(() {
      mockGroupRemoteDatasource = MockGroupRemoteDatasource();
      groupRepoImplUnderTest = GroupRepoImpl(
        groupRemoteDatasource: mockGroupRemoteDatasource,
      );
    });

    group('getGroupFromDatasource', () {
      test(
          'should return GroupEntity when MockGroupRemoteDatasource returns GroupModel',
          () async {
        final userModels = [
          GroupModel(
            id: 1,
            name: 'Group 1',
          ),
        ];

        final userEntities = userModels.map((model) => model).toList();

        when(() => mockGroupRemoteDatasource.getGroupFromApi())
            .thenAnswer((_) async => userModels);

        final result = await groupRepoImplUnderTest.getGroupFromDatasource();

        expect(result, equals(userEntities));
        verify(() => mockGroupRemoteDatasource.getGroupFromApi()).called(1);
        verifyNoMoreInteractions(mockGroupRemoteDatasource);
      });
    });
  });
}
