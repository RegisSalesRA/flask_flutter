part of 'advicer_cubit.dart';

@immutable
sealed class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();

  @override
  List<Object?> get props => [];
}

final class AdvicerInitial extends AdvicerCubitState {}

final class AdvicerStateLoading extends AdvicerCubitState {}

final class AdvicerStateLoaded extends AdvicerCubitState {
  final String advice;
  const AdvicerStateLoaded({required this.advice});
  @override
  List<Object?> get props => [advice];
}

final class AdvicerStateError extends AdvicerCubitState {
  final String message;
  const AdvicerStateError({required this.message});
  @override
  List<Object?> get props => [message];
}
