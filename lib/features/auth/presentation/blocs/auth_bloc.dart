import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/check_auth_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/logout_use_case.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_state.dart';
import 'package:injectable/injectable.dart';

/// Manages the authentication lifecycle for the entire application.
@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._checkAuthUseCase,
  ) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthUseCase _checkAuthUseCase;

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _checkAuthUseCase(const NoParams());
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _registerUseCase(
      RegisterParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase(const NoParams());
    emit(const AuthUnauthenticated());
  }
}
