import 'package:json_annotation/json_annotation.dart';

part 'login_credentials.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials(this.email, this.password);

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginCredentialsToJson(this);
}
