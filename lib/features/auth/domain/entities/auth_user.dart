import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the domain layer.
class AuthUser extends Equatable {
  const AuthUser({
    required this.email,
    required this.token,
    this.id,
  });

  final int? id;

  final String email;

  final String token;

  bool get isAuthenticated => token.isNotEmpty;

  @override
  List<Object?> get props => [id, email, token];
}
