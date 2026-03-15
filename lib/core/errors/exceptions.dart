// Exceptions thrown in the data layer — converted to Failures in repositories.

/// Thrown when the server returns an error response.
class ServerException implements Exception {
  const ServerException({
    this.message = 'Server error occurred.',
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Thrown when there is no internet connection or the request times out.
class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection.']);

  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when a local storage operation fails.
class CacheException implements Exception {
  const CacheException([this.message = 'Cache operation failed.']);

  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when the token is invalid or has expired.
class UnauthorizedException implements Exception {
  const UnauthorizedException([this.message = 'Unauthorized.']);

  final String message;

  @override
  String toString() => 'UnauthorizedException: $message';
}
