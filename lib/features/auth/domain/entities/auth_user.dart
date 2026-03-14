import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the domain layer.
///
/// This is a pure domain entity — no JSON parsing or platform concerns.
/// The data layer is responsible for mapping response models to this entity.
class AuthUser extends Equatable {
  const AuthUser({
    required this.email,
    required this.token,
    this.id,
  });

  /// User ID returned by the auth server. May be null for login-only flows.
  final int? id;

  /// The user's email address.
  final String email;

  /// The Bearer token used to authenticate subsequent requests.
  final String token;

  /// Returns `true` when the entity holds a non-empty token.
  bool get isAuthenticated => token.isNotEmpty;

  @override
  List<Object?> get props => [id, email, token];
}
