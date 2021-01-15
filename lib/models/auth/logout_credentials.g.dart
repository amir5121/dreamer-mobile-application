// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutCredentials _$LogoutCredentialsFromJson(Map<String, dynamic> json) {
  return LogoutCredentials(
    json['token'] as String,
    json['client_id'] as String,
    json['client_secret'] as String,
  );
}

Map<String, dynamic> _$LogoutCredentialsToJson(LogoutCredentials instance) =>
    <String, dynamic>{
      'token': instance.token,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
    };
