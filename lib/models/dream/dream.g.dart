// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) {
  return Dream(
    DateTime.parse(json['created'] as String),
    DateTime.parse(json['modified'] as String),
    json['identifier'] as String,
    User.fromJson(json['user'] as Map<String, dynamic>),
    json['publication_status'] as String,
    json['dream_clearance'] as String,
    json['text'] as String,
    json['title'] as String,
    DateTime.parse(json['dream_date'] as String),
    (json['elements'] as List)
        .map((e) => Element.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['feelings'] as List)
        .map((e) => Feeling.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
      'created': instance.created.toIso8601String(),
      'modified': instance.modified.toIso8601String(),
      'identifier': instance.identifier,
      'user': instance.user,
      'publication_status': instance.publicationStatus,
      'dream_clearance': instance.dreamClearance,
      'text': instance.text,
      'title': instance.title,
      'dream_date': instance.dreamDate.toIso8601String(),
      'elements': instance.elements,
      'feelings': instance.feelings,
    };
