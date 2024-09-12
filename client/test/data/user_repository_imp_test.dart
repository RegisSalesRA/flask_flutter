import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/data/models/user_model.dart';
import 'package:client/data/repositories/user_repo_impl.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRemoteDatasource extends Mock implements UserRemoteDatasource {}

void main() {
  group('UserRepoImpl', () {
    late MockUserRemoteDatasource mockUserRemoteDatasource;
    late UserRepoImpl userRepoImplUnderTest;

    setUp(() {
      mockUserRemoteDatasource = MockUserRemoteDatasource();
      userRepoImplUnderTest = UserRepoImpl(
        userRemoteDatasource: mockUserRemoteDatasource,
      );
    });

    group('getUserFromDatasource', () {
      test(
          'should return UserEntity when MockUserRemoteDatasource returns UserModel',
          () async {
        final userModels = [
          UserModel(
            id: 1,
            firstName: 'John',
            email: 'john@example.com',
            group: const {'id': 1},
          ),
        ];

        final userEntities = userModels
            .map((model) => UserEntity(
                  id: model.id,
                  firstName: model.firstName,
                  email: model.email,
                  group: model.group,
                ))
            .toList();

        when(() => mockUserRemoteDatasource.getUserFromApi())
            .thenAnswer((_) async => userEntities);

        final result = await userRepoImplUnderTest.getUserFromDatasource();

        expect(result, equals(userEntities));
        verify(() => mockUserRemoteDatasource.getUserFromApi()).called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });

      test('should throw an exception when getUserFromApi throws', () async {
        when(() => mockUserRemoteDatasource.getUserFromApi())
            .thenThrow(Exception());

        expect(() => userRepoImplUnderTest.getUserFromDatasource(),
            throwsA(isA<Exception>()));
        verify(() => mockUserRemoteDatasource.getUserFromApi()).called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });
    });

    group('postUserDatasource', () {
      test('postUserDatasource', () async {
        final userModels = [
          UserModel(
              id: 0,
              firstName: 'John',
              email: 'john@example.com',
              group: const {'id': 1}),
        ];

        final userEntities = userModels.map((model) => model).toList();

        when(() => mockUserRemoteDatasource.getUserFromApi())
            .thenAnswer((_) async => userModels);

        final result = await userRepoImplUnderTest.getUserFromDatasource();

        expect(result, equals(userEntities));
        verify(() => mockUserRemoteDatasource.getUserFromApi()).called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });

      test('should throw an exception when postUserFromApi throws', () async {
        final userModel = UserModel(
          id: 1,
          firstName: 'John',
          email: 'john@example.com',
          group: const {'id': 1},
        );

        when(() => mockUserRemoteDatasource.postUserFromApi(userModel))
            .thenThrow(Exception());

        expect(() => userRepoImplUnderTest.postUserDatasource(userModel),
            throwsA(isA<Exception>()));
        verify(() => mockUserRemoteDatasource.postUserFromApi(userModel))
            .called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });
    });

    group('deleteUserDatasource', () {
      test('should call deleteUserFromApi with correct id', () async {
        const userId = 1;

        when(() => mockUserRemoteDatasource.deleteUserFromApi(userId))
            .thenAnswer((_) async => Future.value());

        await userRepoImplUnderTest.deleteUserDataSource(userId);

        verify(() => mockUserRemoteDatasource.deleteUserFromApi(userId))
            .called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });

      test('should throw an exception when deleteUserFromApi throws', () async {
        const userId = 1;

        when(() => mockUserRemoteDatasource.deleteUserFromApi(userId))
            .thenThrow(Exception());

        expect(() => userRepoImplUnderTest.deleteUserDataSource(userId),
            throwsA(isA<Exception>()));
        verify(() => mockUserRemoteDatasource.deleteUserFromApi(userId))
            .called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });
    });

    group('updateUserDatasource', () {
      test('should call updateUserFromApi with correct id', () async {
        const userId = 1;

        when(() => mockUserRemoteDatasource.updateUserFromApi(userId))
            .thenAnswer((_) async => Future.value());

        await userRepoImplUnderTest.updateUserDataSource(userId);

        verify(() => mockUserRemoteDatasource.updateUserFromApi(userId))
            .called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });

      test('should throw an exception when updateUserFromApi throws', () async {
        const userId = 1;

        when(() => mockUserRemoteDatasource.updateUserFromApi(userId))
            .thenThrow(Exception());

        expect(() => userRepoImplUnderTest.updateUserDataSource(userId),
            throwsA(isA<Exception>()));
        verify(() => mockUserRemoteDatasource.updateUserFromApi(userId))
            .called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });
    });

    group('getuserfilterbygroupdatasource', () {
      test('should return filtered UserEntities by group name', () async {
        const groupName = 'grupo1';

        final userModels = [
          const UserEntity(
            id: 1,
            firstName: 'John',
            email: 'john@example.com',
            group: {'id': 1, 'name': groupName},
          ),
        ];

        when(() => mockUserRemoteDatasource
                .getuserfilterbygroupdatasourceFromApi(groupName))
            .thenAnswer((_) async => userModels);

        final result = await userRepoImplUnderTest
            .getuserfilterbygroupdatasource(groupName);

        expect(result, equals(userModels));

        verify(() => mockUserRemoteDatasource
            .getuserfilterbygroupdatasourceFromApi(groupName)).called(1);

        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });

      test(
          'should throw an exception when getuserfilterbygroupdatasourceFromApi throws',
          () async {
        const groupName = 'grupo1';

        when(() => mockUserRemoteDatasource
                .getuserfilterbygroupdatasourceFromApi(groupName))
            .thenThrow(Exception());

        expect(
            () =>
                userRepoImplUnderTest.getuserfilterbygroupdatasource(groupName),
            throwsA(isA<Exception>()));
        verify(() => mockUserRemoteDatasource
            .getuserfilterbygroupdatasourceFromApi(groupName)).called(1);
        verifyNoMoreInteractions(mockUserRemoteDatasource);
      });
    });
  });
}
