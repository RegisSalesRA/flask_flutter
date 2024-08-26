import 'package:client/application/pages/users/bloc/users_bloc_bloc.dart';
import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/data/repositories/user_repo_impl.dart';
import 'package:client/domain/repositories/user_repository.dart';
import 'package:client/domain/usecases/user_usercases.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
// ! application Layer
  // Factory = every time a new/fresh instance of that class
  sl.registerFactory(() => UserBloc(userUseCases: sl()));

// ! domain Layer
  sl.registerFactory(() => UserUseCases(userRepo: sl()));

// ! data Layer
  sl.registerFactory<UserRepo>(() => UserRepoImpl(userRemoteDatasource: sl()));
  sl.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(client: sl()));

// ! externs
  sl.registerFactory(() => http.Client());
}
