// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      json['messageCode'] as String,
      json['message'] as String?,
      json['code'] as int,
      PostPagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
