// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertToken _$ConvertTokenFromJson(Map<String, dynamic> json) {
  return ConvertToken(
    json['client_id'] as String,
    json['client_secret'] as String,
    json['token'] as String,
    json['backend'] as String,
  );
}

Map<String, dynamic> _$ConvertTokenToJson(ConvertToken instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'token': instance.token,
      'backend': instance.backend,
    };
