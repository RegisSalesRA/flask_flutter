  import '../pages/users/bloc/users_bloc.dart';

UserError handleError(dynamic e) {
    if (e is NetworkException) {
      return UserError("Network Error: ${e.message}");
    } else if (e is TimeoutException) {
      return UserError("Request timed out. Please try again.");
    } else {
      return UserError("Unexpected error occurred: ${e.toString()}");
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
