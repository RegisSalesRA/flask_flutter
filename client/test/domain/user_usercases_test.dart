import 'package:client/data/models/user_model.dart';
import 'package:client/data/repositories/user_repo_impl.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/usecases/user_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRepoImpl extends Mock implements UserRepoImpl {}

void main() {
  group(
    'User Usecases',
    () {
      late MockUserRepoImpl mockUserRepoImp;
      late UserUseCases userUseCases;

      setUp(() {
        mockUserRepoImp = MockUserRepoImpl();
        userUseCases = UserUseCases(userRepo: mockUserRepoImp);
      });

      test(
        'Get users from userUsercase',
        () async {
          final userModels = [
            UserModel(
                id: 1,
                firstName: 'John',
                email: 'john@example.com',
                group: const {'id': 1}),
          ];

          final userEntities = userModels
              .map((model) => UserEntity(
                    id: model.id,
                    firstName: model.firstName,
                    email: model.email,
                    group: model.group,
                  ))
              .toList();

          when(() => mockUserRepoImp.getUserFromDatasource())
              .thenAnswer((_) async => userEntities);

          final result = await userUseCases.getusers();

          expect(result, equals(userEntities));
          verify(() => mockUserRepoImp.getUserFromDatasource()).called(1);
          verifyNoMoreInteractions(mockUserRepoImp);
        },
      );
    },
  );
}
