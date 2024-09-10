import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/data/models/user_model.dart';
import 'package:client/domain/entities/user_entity.dart';
import 'package:client/domain/usecases/user_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserUseCases extends Mock implements UserUseCases {}

void main() {
  group('UserBloc', () {
    late MockUserUseCases mockUserUseCases;

    setUp(() {
      mockUserUseCases = MockUserUseCases();
    });

    blocTest<UserBloc, UserState>(
      'emits nothing when no event is added',
      build: () => UserBloc(userUseCases: mockUserUseCases),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateLoaded] when GetUsers event is added',
      setUp: () => when(() => mockUserUseCases.getusers()).thenAnswer(
        (_) => Future.value([
          const UserEntity(
            id: 1,
            email: 'john.doe@example.com',
            firstName: 'John',
            group: {'name': 'Group1'},
          ),
          const UserEntity(
            id: 2,
            email: 'jane.doe@example.com',
            firstName: 'Jane',
            group: {'name': 'Group2'},
          ),
        ]),
      ),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(GetUsers()),
      expect: () => [
        UserStateLoading(),
        UserStateLoaded(const [
          UserEntity(
            id: 1,
            email: 'john.doe@example.com',
            firstName: 'John',
            group: {'name': 'Group1'},
          ),
          UserEntity(
            id: 2,
            email: 'jane.doe@example.com',
            firstName: 'Jane',
            group: {'name': 'Group2'},
          ),
        ]),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateError] when GetUsers event fails',
      setUp: () => when(() => mockUserUseCases.getusers())
          .thenThrow(Exception('error message')),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(GetUsers()),
      expect: () => [
        UserStateLoading(),
        UserStateError(
            message: 'Unexpected error occurred: Exception: error message'),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateLoaded] when PostUser event is added',
      setUp: () => when(() => mockUserUseCases.postusers(any())).thenAnswer(
        (_) async => Future.value(),
      ),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(PostUser(UserModel(
        id: 1,
        email: 'john.doe@example.com',
        firstName: 'John',
        group: const {'name': 'Group1'},
      ))),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateError] when PostUser event fails',
      setUp: () {
        when(() => mockUserUseCases.postusers(any()))
            .thenThrow(Exception('error message'));
      },
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(PostUser(UserModel(
        id: 1,
        email: 'john.doe@example.com',
        firstName: 'John',
        group: const {'name': 'Group1'},
      ))),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateLoaded] when UpdateUser event is added',
      setUp: () => when(() => mockUserUseCases.updateusers(any())).thenAnswer(
        (_) async => Future.value(),
      ),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(UpdateUser(UserModel(
        id: 1,
        email: 'john.smith@example.com',
        firstName: 'John',
        group: const {'name': 'Group1'},
      ))),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateError] when UpdateUser event fails',
      setUp: () => when(() => mockUserUseCases.updateusers(any()))
          .thenThrow(Exception('error message')),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(UpdateUser(UserModel(
        id: 1,
        email: 'john.smith@example.com',
        firstName: 'John',
        group: const {'name': 'Group1'},
      ))),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateLoaded] when DeleteUser event is added',
      setUp: () {
        when(() => mockUserUseCases.deleteusers(any())).thenAnswer(
          (_) async => Future.value(),
        );

        when(() => mockUserUseCases.getusers()).thenAnswer(
          (_) async => [
            const UserEntity(
              id: 1,
              email: 'john.doe@example.com',
              firstName: 'John',
              group: {'name': 'Group1'},
            ),
          ],
        );
      },
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(const DeleteUser(1)),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateError] when DeleteUser event fails',
      setUp: () => when(() => mockUserUseCases.deleteusers(any()))
          .thenThrow(Exception('error message')),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(const DeleteUser(1)),
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateLoaded] when GetFilterUsers event is added',
      setUp: () =>
          when(() => mockUserUseCases.getuserfilterbygroup(any())).thenAnswer(
        (_) => Future.value([
          const UserEntity(
            id: 1,
            email: 'john.doe@example.com',
            firstName: 'John',
            group: {'name': 'Group1'},
          ),
        ]),
      ),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(const GetFilterUsers('Group1')),
      expect: () => [
        UserStateLoading(),
        UserStateLoaded(const [
          UserEntity(
            id: 1,
            email: 'john.doe@example.com',
            firstName: 'John',
            group: {'name': 'Group1'},
          ),
        ]),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserStateLoading, UserStateError] when GetFilterUsers event fails',
      setUp: () => when(() => mockUserUseCases.getuserfilterbygroup(any()))
          .thenThrow(Exception('error message')),
      build: () => UserBloc(userUseCases: mockUserUseCases),
      act: (bloc) => bloc.add(const GetFilterUsers('Group1')),
      expect: () => [
        UserStateLoading(),
        UserStateError(
            message: 'Unexpected error occurred: Exception: error message'),
      ],
    );
  });
}
