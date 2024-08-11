import 'package:client/data/repositories/advice_repo_impl.dart';
import 'package:client/domain/entities/advice_entity.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUserCases {
  final advicecRepo = AdviceRepoImpl();
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return advicecRepo.getAdviceFromDatasource();
  }
}
