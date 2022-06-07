// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsResponse _$AnalyticsResponseFromJson(Map<String, dynamic> json) =>
    AnalyticsResponse(
      json['message_code'] as String?,
      json['message'] as String?,
      json['code'] as int?,
      Analytics.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnalyticsResponseToJson(AnalyticsResponse instance) =>
    <String, dynamic>{
      'message_code': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
