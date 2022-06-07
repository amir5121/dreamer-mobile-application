import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthTokens {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final String? scope;
  final int? expiresIn;

  AuthTokens(
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.scope,
    this.expiresIn,
  );

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokensToJson(this);
}
