import 'package:client/data/repositories/advice_repo_impl.dart';
import 'package:client/domain/entities/advice_entity.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:client/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceUserCases {
  AdviceUserCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
  }
}
