part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerEvent {}


class AviceRequestedEvent extends AdvicerEvent {}