part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState {}

final class AdvicerInitial extends AdvicerState {}

final class AdvicerStateLoading extends AdvicerState {}

final class AdvicerStateLoaded extends AdvicerState {
  final String advice;
  AdvicerStateLoaded({required this.advice});
}

final class AdvicerStateError extends AdvicerState {
  final String message;
  AdvicerStateError({required this.message});
}
