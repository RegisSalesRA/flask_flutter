import 'package:client/data/models/group_model.dart';
import 'package:client/data/repositories/group_repo_impl.dart';
import 'package:client/domain/entities/group_entity.dart';
import 'package:client/domain/usecases/group_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGroupRepoImpl extends Mock implements GroupRepoImpl {}

void main() {
  group(
    'Group Usecases',
    () {
      late MockGroupRepoImpl mockGroupRepoImp;
      late GroupUseCases groupUseCases;

      setUp(() {
        mockGroupRepoImp = MockGroupRepoImpl();
        groupUseCases = GroupUseCases(groupRepo: mockGroupRepoImp);
      });

      test(
        'Get groups from groupUsecase',
        () async {
          final groupModels = [
            GroupModel(
              id: 1,
              name: 'Group 1',
            ),
          ];

          final groupEntities = groupModels
              .map((model) => GroupEntity(
                    id: model.id,
                    name: model.name,
                  ))
              .toList();

          when(() => mockGroupRepoImp.getGroupFromDatasource())
              .thenAnswer((_) async => groupEntities);

          final result = await groupUseCases.getgroups();

          expect(result, equals(groupEntities));
          verify(() => mockGroupRepoImp.getGroupFromDatasource()).called(1);
          verifyNoMoreInteractions(mockGroupRepoImp);
        },
      );

      test(
        'Post groups from groupUsecase',
        () async {
          var group = GroupModel(
            id: 1,
            name: 'Group 1',
          );

          when(() => mockGroupRepoImp.postGroupDatasource(group))
              .thenAnswer((_) async => Future.value());

          await groupUseCases.postgroups(group);

          verify(() => mockGroupRepoImp.postGroupDatasource(group)).called(1);
          verifyNoMoreInteractions(mockGroupRepoImp);
        },
      );
    },
  );
}
