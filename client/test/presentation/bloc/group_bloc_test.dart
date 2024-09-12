import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/data/models/group_model.dart';
import 'package:client/domain/entities/group_entity.dart';
import 'package:client/domain/usecases/group_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGroupUseCases extends Mock implements GroupUseCases {}

void main() {
  group('GroupBloc', () {
    late MockGroupUseCases mockGroupUseCases;

    setUp(() {
      mockGroupUseCases = MockGroupUseCases();
    });

    blocTest<GroupBloc, GroupState>(
      'emits nothing when no event is added',
      build: () => GroupBloc(groupUseCases: mockGroupUseCases),
      expect: () => [],
    );

    blocTest<GroupBloc, GroupState>(
      'emits [GroupLoading, GroupLoaded] when LoadGroups event is added',
      setUp: () => when(() => mockGroupUseCases.getgroups()).thenAnswer(
        (_) async => [
          const GroupEntity(id: 1, name: 'group 1'),
          const GroupEntity(id: 2, name: 'group 2'),
        ],
      ),
      build: () => GroupBloc(groupUseCases: mockGroupUseCases),
      act: (bloc) => bloc.add(LoadGroups()),
      expect: () => [
        GroupLoading(),
        GroupLoaded(const [
          GroupEntity(id: 1, name: 'group 1'),
          GroupEntity(id: 2, name: 'group 2'),
        ]),
      ],
    );

    blocTest<GroupBloc, GroupState>(
      'emits [GroupLoading, GroupError] when LoadGroups event fails',
      setUp: () => when(() => mockGroupUseCases.getgroups())
          .thenThrow(Exception('error message')),
      build: () => GroupBloc(groupUseCases: mockGroupUseCases),
      act: (bloc) => bloc.add(LoadGroups()),
      expect: () => [
        GroupLoading(),
        GroupError(
            message: 'Unexpected error occurred: Exception: error message'),
      ],
    );
    blocTest<GroupBloc, GroupState>(
      'emits [GroupLoaded] when AddGroup event is added, starting from an empty state',
      setUp: () {
        when(() => mockGroupUseCases.postgroups(any()))
            .thenAnswer((_) async => Future.value());
      },
      build: () => GroupBloc(groupUseCases: mockGroupUseCases),
      seed: () => GroupLoaded(const []),
      act: (bloc) =>
          bloc.add(const AddGroup(GroupEntity(id: 1, name: 'Group 1'))),
      expect: () => [
        GroupLoaded(const [GroupEntity(id: 1, name: 'Group 1')]),
      ],
    );

    blocTest<GroupBloc, GroupState>(
      'emits [GroupLoading, GroupError] when AddGroup event fails',
      setUp: () {
        when(() => mockGroupUseCases.postgroups(any()))
            .thenThrow(Exception('error message'));
      },
      build: () => GroupBloc(groupUseCases: mockGroupUseCases),
      act: (bloc) => bloc.add(AddGroup(GroupModel(id: 1, name: 'Group 1'))),
      expect: () => [
        GroupError(
            message: 'Unexpected error occurred: Exception: error message'),
      ],
    );
  });
}
