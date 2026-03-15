/// DTO that maps the JSON response from the auth endpoints to a Dart object.
///
/// Used only in the data layer — converted to [AuthUser] before leaving
/// [AuthRepositoryImpl].
///
/// API response shape (`AuthResponseDto`):
/// ```json
/// { "accessToken": "...", "refreshToken": "..." }
/// ```
class AuthResponseModel {
  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    this.email = '',
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Response is wrapped in an envelope: { success, timestamp, data: { ... } }
    final data = (json['data'] ?? json) as Map<String, dynamic>;
    return AuthResponseModel(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }

  final String accessToken;
  final String refreshToken;

  /// Email is not returned by the API but carried through from the request
  /// so [AuthRepositoryImpl] can build a complete [AuthUser] entity.
  final String email;
}
