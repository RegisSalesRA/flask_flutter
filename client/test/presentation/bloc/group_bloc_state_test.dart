import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/domain/usecases/group_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGroupUseCases extends Mock implements GroupUseCases {}

void main() {
  group('GroupBloc', () {
    late MockGroupUseCases groupUseCasesMock;

    setUp(() {
      groupUseCasesMock = MockGroupUseCases();

      when(() => groupUseCasesMock.getgroups()).thenThrow(
          Exception('Unexpected error occurred: Exception: error message'));
    });

    group('should emit', () {
      blocTest<GroupBloc, GroupState>(
        'Nothing when no event is added',
        build: () => GroupBloc(groupUseCases: groupUseCasesMock),
        expect: () => const <GroupState>[],
      );

      blocTest<GroupBloc, GroupState>(
        '[GroupLoading, GroupError] when Exception occurs',
        setUp: () => when(() => groupUseCasesMock.getgroups())
            .thenThrow(Exception('error message')),
        build: () => GroupBloc(groupUseCases: groupUseCasesMock),
        act: (bloc) => bloc.add(LoadGroups()),
        wait: const Duration(seconds: 3),
        expect: () => <GroupState>[
          GroupLoading(),
          GroupError(
              message: 'Unexpected error occurred: Exception: error message'),
        ],
      );
    });
  });
}
