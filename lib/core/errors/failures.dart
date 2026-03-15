import 'package:equatable/equatable.dart';

/// Base class for all domain-layer failures.
abstract class Failure extends Equatable {
  const Failure([this.message = '']);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() => '$runtimeType: $message';
}

/// Failure due to no internet connection or timeout.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred.']);
}

/// Failure due to server returning an error response (4xx, 5xx).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred.']);

  const ServerFailure.withCode(int statusCode)
      : super('Server error with status code: $statusCode');
}

/// Failure due to invalid token or expired session (401).
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Unauthorized. Please login again.',
  ]);
}

/// Failure when reading/writing data from local storage.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local cache error occurred.']);
}

/// Failure due to invalid user input.
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid input.']);
}
