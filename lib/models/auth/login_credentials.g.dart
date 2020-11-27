// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) {
  return LoginCredentials(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginCredentialsToJson(LoginCredentials instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
