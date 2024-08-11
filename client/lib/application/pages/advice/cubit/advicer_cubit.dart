import 'package:bloc/bloc.dart';
import 'package:client/domain/failures/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../domain/usecases/advice_usercases.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUseCases adviceUseCases;
  AdvicerCubit({required this.adviceUseCases}) : super(AdvicerInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
        (failure) =>
            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ups server fail";
      case CacheFailure:
        return "ups cash fail";
      default:
        return 'ups something unknown default';
    }
  }
}
