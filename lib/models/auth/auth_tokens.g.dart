// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => AuthTokens(
      json['access_token'] as String?,
      json['refresh_token'] as String?,
      json['token_type'] as String?,
      json['scope'] as String?,
      json['expires_in'] as int?,
    );

Map<String, dynamic> _$AuthTokensToJson(AuthTokens instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'scope': instance.scope,
      'expires_in': instance.expiresIn,
    };
