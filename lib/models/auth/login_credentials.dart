import 'package:json_annotation/json_annotation.dart';

part 'login_credentials.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginCredentials {
  final String username;
  final String password;
  final String clientId;
  final String clientSecret;

  final String grantType;

  LoginCredentials(
    this.username,
    this.password,
    this.clientId,
    this.clientSecret,
    this.grantType,
  );

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginCredentialsToJson(this);
}
