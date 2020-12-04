// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    User.fromJson(json['user'] as Map<String, dynamic>),
    DateTime.parse(json['created'] as String),
    json['modified'] as String,
    json['status'] as String,
    (json['text'] as List).map((e) => e as String).toList(),
    json['identifier'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'user': instance.user,
      'created': instance.created.toIso8601String(),
      'modified': instance.modified,
      'status': instance.status,
      'text': instance.text,
      'identifier': instance.identifier,
    };
