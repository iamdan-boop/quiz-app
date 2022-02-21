import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthToken {
  AuthToken({
    required this.authToken,
    required this.name,
    required this.isAdmin,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  final String authToken;
  final String name;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
}
