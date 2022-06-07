// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dreamer_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamerNotification _$DreamerNotificationFromJson(Map<String, dynamic> json) =>
    DreamerNotification(
      json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
      json['identifier'] as String?,
      json['text'] as String?,
      json['title'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$DreamerNotificationToJson(
        DreamerNotification instance) =>
    <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'modified': instance.modified?.toIso8601String(),
      'identifier': instance.identifier,
      'text': instance.text,
      'title': instance.title,
      'image': instance.image,
    };
