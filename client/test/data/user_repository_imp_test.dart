import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/data/models/user_model.dart';
import 'package:client/data/repositories/user_repo_impl.dart';
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
    });
  });
}
