import 'package:bloc_test/bloc_test.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/domain/usecases/user_usercase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserUseCases extends Mock implements UserUseCases {}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

void main() {
  group('UserBloc', () {
    late MockUserUseCases userUseCasesMock;

    setUp(() {
      userUseCasesMock = MockUserUseCases();

      when(() => userUseCasesMock.getusers())
          .thenThrow(Exception('error message'));
    });

    group('should emit', () {
      blocTest<UserBloc, UserState>(
        'Nothing when no event is added',
        build: () => UserBloc(userUseCases: userUseCasesMock),
        expect: () => const <UserState>[],
      );

      blocTest<UserBloc, UserState>(
        '[UserStateLoading, UserStateError] error Exception',
        build: () => UserBloc(userUseCases: userUseCasesMock),
        act: (bloc) => bloc.add(GetUsers()),
        wait: const Duration(seconds: 3),
        expect: () => <UserState>[
          UserStateLoading(),
          UserStateError(
              message: 'Unexpected error occurred: Exception: error message')
        ],
      );
    });
  });
}
