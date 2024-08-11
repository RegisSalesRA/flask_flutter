import 'package:client/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:client/data/repositories/advice_repo_impl.dart';
import 'package:client/domain/repositories/advice_repository.dart';
import 'package:client/domain/usecases/advice_usercases.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I; // service location

Future<void> init() async {
  // ! application layer
  // Factory = every time a new /frehs instance of that class
  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));

  // Domain layer
  sl.registerFactory(() => AdviceUserCases(adviceRepo: sl()));

  // Data layer
  sl.registerFactory<AdviceRepo>(() => AdviceRepoImpl(adviceRemoteDatasource: sl()));
}
