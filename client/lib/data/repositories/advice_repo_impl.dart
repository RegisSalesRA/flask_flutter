import 'package:client/data/datasource/advice_remote_datasource.dart';
import 'package:client/data/exceptions/exceptions.dart';
import 'package:client/domain/entities/advice_entity.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:client/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';


class AdviceRepoImpl implements AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;
  
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}