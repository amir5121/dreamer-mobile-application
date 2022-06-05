// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationsResponse _$ConfigurationsResponseFromJson(
        Map<String, dynamic> json) =>
    ConfigurationsResponse(
      json['message_code'] as String,
      json['message'] as String?,
      json['code'] as int,
      Configurations.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigurationsResponseToJson(
        ConfigurationsResponse instance) =>
    <String, dynamic>{
      'message_code': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
