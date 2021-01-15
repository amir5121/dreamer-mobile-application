import 'package:json_annotation/json_annotation.dart';

part 'logout_credentials.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class LogoutCredentials {
  final String token;
  final String clientId;
  final String clientSecret;

  LogoutCredentials(
    this.token,
    this.clientId,
    this.clientSecret,
  );

  factory LogoutCredentials.fromJson(Map<String, dynamic> json) =>
      _$LogoutCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutCredentialsToJson(this);
}
