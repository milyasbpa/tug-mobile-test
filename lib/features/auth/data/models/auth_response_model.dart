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

  final String email;
}
