import 'package:client/application/pages/groups/bloc/group_bloc.dart';
import 'package:client/application/pages/users/bloc/users_bloc.dart';
import 'package:client/data/datasource/group_remote_datasource.dart';
import 'package:client/data/datasource/user_remote_datasource.dart';
import 'package:client/data/repositories/group_repo_impl.dart';
import 'package:client/data/repositories/user_repo_impl.dart';
import 'package:client/domain/repositories/group_repository.dart';
import 'package:client/domain/repositories/user_repository.dart';
import 'package:client/domain/usecases/group_usercase.dart';
import 'package:client/domain/usecases/user_usercase.dart';
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

// ! application Layer
  // Factory = every time a new/fresh instance of that class
  sl.registerFactory(() => GroupBloc(groupUseCases: sl()));

// ! domain Layer
  sl.registerFactory(() => GroupUseCases(groupRepo: sl()));

// ! data Layer
  sl.registerFactory<GroupRepo>(
      () => GroupRepoImpl(groupRemoteDatasource: sl()));
  sl.registerFactory<GroupRemoteDatasource>(
      () => GroupRemoteDatasourceImpl(client: sl()));

// ! externs
  sl.registerFactory(() => http.Client());
}
