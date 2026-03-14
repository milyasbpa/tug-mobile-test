import 'package:equatable/equatable.dart';

/// Base class for all events dispatched to [AuthBloc].
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Dispatched on app start to restore an existing session from storage.
final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Dispatched when the user submits the login form.
final class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

/// Dispatched when the user submits the registration form.
final class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

/// Dispatched when the user taps the logout button.
final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
