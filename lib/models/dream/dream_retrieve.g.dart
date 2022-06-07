// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_retrieve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamRetrieve _$DreamRetrieveFromJson(Map<String, dynamic> json) =>
    DreamRetrieve(
      json['messageCode'] as String?,
      json['message'] as String?,
      json['code'] as int?,
      Dream.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DreamRetrieveToJson(DreamRetrieve instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
