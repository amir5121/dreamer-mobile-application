// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) {
  return PostResponse(
    json['message'] as String,
    json['code'] as int,
    json['data'] == null
        ? null
        : PostPagination.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
