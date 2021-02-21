// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return NotificationResponse(
    json['messageCode'] as String,
    json['message'] as String,
    json['code'] as int,
    json['data'] == null
        ? null
        : NotificationPagination.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotificationResponseToJson(NotificationResponse instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
