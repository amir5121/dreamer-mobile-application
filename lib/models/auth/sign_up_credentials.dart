import 'package:json_annotation/json_annotation.dart';

part 'sign_up_credentials.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class SignUpCredentials {
  final String email;
  final String password;
  final String rePassword;

  SignUpCredentials(this.email, this.password, this.rePassword);

  factory SignUpCredentials.fromJson(Map<String, dynamic> json) =>
      _$SignUpCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpCredentialsToJson(this);
}
