import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/check_auth_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/logout_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

// Thin wrappers so bloc_test can instantiate use-cases with the mock repo.
class _MockLoginUseCase extends Mock implements LoginUseCase {}

class _MockRegisterUseCase extends Mock implements RegisterUseCase {}

class _MockLogoutUseCase extends Mock implements LogoutUseCase {}

class _MockCheckAuthUseCase extends Mock implements CheckAuthUseCase {}

void main() {
  late _MockLoginUseCase mockLogin;
  late _MockRegisterUseCase mockRegister;
  late _MockLogoutUseCase mockLogout;
  late _MockCheckAuthUseCase mockCheckAuth;

  setUpAll(() {
    // Register fallback values for named parameters used in matchers.
    registerFallbackValue(const LoginParams(email: '', password: ''));
    registerFallbackValue(const RegisterParams(email: '', password: ''));
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    mockLogin = _MockLoginUseCase();
    mockRegister = _MockRegisterUseCase();
    mockLogout = _MockLogoutUseCase();
    mockCheckAuth = _MockCheckAuthUseCase();
  });

  AuthBloc buildBloc() => AuthBloc(
        mockLogin,
        mockRegister,
        mockLogout,
        mockCheckAuth,
      );

  // ── AuthCheckRequested ────────────────────────────────────────────────────

  group('AuthCheckRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when token exists',
      build: buildBloc,
      setUp: () => when(() => mockCheckAuth(any()))
          .thenAnswer((_) async => const Right(tStoredAuthUser)),
      act: (bloc) => bloc.add(const AuthCheckRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(user: tStoredAuthUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] when no token is stored',
      build: buildBloc,
      setUp: () => when(() => mockCheckAuth(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure())),
      act: (bloc) => bloc.add(const AuthCheckRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthUnauthenticated(),
      ],
    );
  });

  // ── AuthLoginRequested ────────────────────────────────────────────────────

  group('AuthLoginRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on successful login',
      build: buildBloc,
      setUp: () => when(() => mockLogin(any()))
          .thenAnswer((_) async => const Right(tAuthUser)),
      act: (bloc) => bloc.add(
        const AuthLoginRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(user: tAuthUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when login fails with network error',
      build: buildBloc,
      setUp: () => when(() => mockLogin(any()))
          .thenAnswer((_) async => const Left(NetworkFailure())),
      act: (bloc) => bloc.add(
        const AuthLoginRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthError(message: 'Network error occurred.'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when login fails with server error',
      build: buildBloc,
      setUp: () => when(() => mockLogin(any())).thenAnswer(
        (_) async => const Left(ServerFailure('Invalid credentials')),
      ),
      act: (bloc) => bloc.add(
        const AuthLoginRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthError(message: 'Invalid credentials'),
      ],
    );
  });

  // ── AuthRegisterRequested ─────────────────────────────────────────────────

  group('AuthRegisterRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on successful registration',
      build: buildBloc,
      setUp: () => when(() => mockRegister(any()))
          .thenAnswer((_) async => const Right(tAuthUser)),
      act: (bloc) => bloc.add(
        const AuthRegisterRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(user: tAuthUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when registration fails',
      build: buildBloc,
      setUp: () => when(() => mockRegister(any())).thenAnswer(
        (_) async => const Left(
          ServerFailure('Note: Only defined users succeed registration'),
        ),
      ),
      act: (bloc) => bloc.add(
        const AuthRegisterRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthError(
          message: 'Note: Only defined users succeed registration',
        ),
      ],
    );
  });

  // ── AuthLogoutRequested ───────────────────────────────────────────────────

  group('AuthLogoutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] on logout',
      build: buildBloc,
      setUp: () => when(() => mockLogout(any()))
          .thenAnswer((_) async => const Right(unit)),
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      expect: () => [const AuthUnauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] even when logout storage clear fails',
      build: buildBloc,
      setUp: () => when(() => mockLogout(any()))
          .thenAnswer((_) async => const Left(CacheFailure())),
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      // AuthBloc ignores logout failure and always clears state.
      expect: () => [const AuthUnauthenticated()],
    );
  });
}
