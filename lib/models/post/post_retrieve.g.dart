// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_retrieve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRetrieve _$PostRetrieveFromJson(Map<String, dynamic> json) => PostRetrieve(
      json['messageCode'] as String,
      json['message'] as String,
      json['code'] as int,
      Post.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostRetrieveToJson(PostRetrieve instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
