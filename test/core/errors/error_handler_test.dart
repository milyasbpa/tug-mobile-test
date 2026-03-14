import 'package:flutter_starter_kit/core/errors/error_handler.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorHandler.failureToMessage', () {
    test('maps NetworkFailure with no message to default network string', () {
      final result = ErrorHandler.failureToMessage(const NetworkFailure());
      expect(result, contains('Network'));
    });

    test('maps NetworkFailure with custom message to that message', () {
      final result = ErrorHandler.failureToMessage(
        const NetworkFailure('Custom network error'),
      );
      expect(result, 'Custom network error');
    });

    test('maps UnauthorizedFailure to session-expired string', () {
      final result = ErrorHandler.failureToMessage(const UnauthorizedFailure());
      expect(result, contains('session'));
    });

    test('maps ServerFailure with no message to default server string', () {
      final result = ErrorHandler.failureToMessage(const ServerFailure());
      expect(result, contains('Server'));
    });

    test('maps ServerFailure with custom message to that message', () {
      final result = ErrorHandler.failureToMessage(
        const ServerFailure('Maintenance in progress'),
      );
      expect(result, 'Maintenance in progress');
    });

    test('maps CacheFailure to local storage string', () {
      final result = ErrorHandler.failureToMessage(const CacheFailure());
      expect(result, contains('saved data'));
    });

    test('maps ValidationFailure with message to that message', () {
      final result = ErrorHandler.failureToMessage(
        const ValidationFailure('Email is required'),
      );
      expect(result, 'Email is required');
    });

    test('maps ValidationFailure with no message to default invalid string',
        () {
      final result = ErrorHandler.failureToMessage(const ValidationFailure());
      expect(result, contains('Invalid'));
    });
  });
}
