// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertToken _$ConvertTokenFromJson(Map<String, dynamic> json) {
  return ConvertToken(
    clientId: json['client_id'] as String,
    clientSecret: json['client_secret'] as String,
    token: json['token'] as String,
    backend: json['backend'] as String,
    grantType: json['grant_type'] as String,
  );
}

Map<String, dynamic> _$ConvertTokenToJson(ConvertToken instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'token': instance.token,
      'backend': instance.backend,
      'grant_type': instance.grantType,
    };
