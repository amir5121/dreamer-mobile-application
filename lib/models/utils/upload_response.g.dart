// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      json['message_code'] as String,
      json['message'] as String?,
      json['code'] as int,
      UploadedFile.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'message_code': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
