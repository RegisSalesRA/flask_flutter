import 'package:client/domain/entities/advice_entity.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUserCases {
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    await Future.delayed(Duration(seconds: 3), () {});
    return right(AdviceEntity(advice: 'advice to test', id: 1));
    //  return left(ServerFailure());
  }
}
