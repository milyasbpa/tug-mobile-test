/// DTO that maps the JSON response from the auth endpoints to a Dart object.
///
/// Used only in the data layer — converted to [AuthUser] before leaving
/// [AuthRepositoryImpl].
///
/// reqres.in login response:  `{"token": "..."}`
/// reqres.in register response: `{"id": 4, "token": "..."}`
class AuthResponseModel {
  const AuthResponseModel({
    required this.token,
    this.id,
    this.email = '',
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        id: json['id'] as int?,
        token: json['token'] as String,
      );

  final int? id;
  final String token;

  /// Email is not returned by reqres.in but carried through from the request
  /// so [AuthRepositoryImpl] can build a complete [AuthUser] entity.
  final String email;
}
