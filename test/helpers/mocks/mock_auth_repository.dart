import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

/// Mocktail mock for [AuthRepository].
///
/// Use this in tests instead of creating a real repository that depends on
/// network or local storage. Register fallback values once in `setUpAll`:
/// ```dart
/// setUpAll(() => registerFallbackValues());
/// ```
class MockAuthRepository extends Mock implements AuthRepository {}
