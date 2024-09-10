import 'package:client/application/pages/groups/bloc/group_bloc.dart';

import '../pages/users/bloc/users_bloc.dart';

UserStateError handleError(dynamic e) {
  if (e is NetworkException) {
    return UserStateError(message: "Network Error: ${e.message}");
  } else if (e is TimeoutException) {
    return UserStateError(message: "Request timed out. Please try again.");
  } else {
    return UserStateError(
        message: "Unexpected error occurred: ${e.toString()}");
  }
}

GroupError handleErrorGroup(dynamic e) {
  if (e is NetworkException) {
    return GroupError("Network Error: ${e.message}");
  } else if (e is TimeoutException) {
    return GroupError("Request timed out. Please try again.");
  } else {
    return GroupError("Unexpected error occurred: ${e.toString()}");
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException([this.message = 'Request timed out']);

  @override
  String toString() => message;
}
