import 'package:json_annotation/json_annotation.dart';

part 'convert_token.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class ConvertToken {
  final String clientId;
  final String clientSecret;
  final String token;
  final String backend;

  ConvertToken(
    this.clientId,
    this.clientSecret,
    this.token,
    this.backend,
  );

  factory ConvertToken.fromJson(Map<String, dynamic> json) =>
      _$ConvertTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertTokenToJson(this);
}
