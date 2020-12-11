// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    DateTime.parse(json['created'] as String),
    (json['text'] as List).map((e) => e as String).toList(),
    json['id'] as int,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'text': instance.text,
    };
