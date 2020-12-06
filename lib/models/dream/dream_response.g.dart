// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamResponse _$DreamResponseFromJson(Map<String, dynamic> json) {
  return DreamResponse(
    json['messageCode'] as String,
    json['message'] as String,
    json['code'] as int,
    json['data'] == null
        ? null
        : DreamPagination.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DreamResponseToJson(DreamResponse instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
