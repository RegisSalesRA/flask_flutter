import 'package:client/domain/entities/advice_entity.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepo {
  Future<Either<Failure,AdviceEntity>> getAdviceFromDatasource();
}
