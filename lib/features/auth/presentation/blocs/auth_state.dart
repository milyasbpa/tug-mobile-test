import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';

/// Base class for all states emitted by [AuthBloc].
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// App has just launched — auth status not yet determined.
///
/// The router stays on its current location until this resolves.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// An auth operation is in progress (checking, logging in, registering).
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// The user has a valid session and is authenticated.
final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.user});

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}

/// No valid session exists — user must log in.
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// An auth operation failed with a user-facing [message].
final class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
