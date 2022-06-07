// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) =>
    LoginCredentials(
      json['username'] as String,
      json['password'] as String,
      json['client_id'] as String,
      json['client_secret'] as String,
      json['grant_type'] as String,
    );

Map<String, dynamic> _$LoginCredentialsToJson(LoginCredentials instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'grant_type': instance.grantType,
    };
