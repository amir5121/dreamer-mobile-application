// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      modified: json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
      identifier: json['identifier'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      publicationStatus: json['publication_status'] as String?,
      dreamClearance: json['dream_clearance'] as int?,
      text: json['text'] as String?,
      title: json['title'] as String?,
      dreamDate: json['dream_date'] == null
          ? null
          : DateTime.parse(json['dream_date'] as String),
      dreamClearanceDisplay: json['dream_clearance_display'] as String?,
      voice: json['voice'] as String?,
      elements: (json['elements'] as List<dynamic>?)
          ?.map((e) => DreamElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      voiceWave: (json['voice_wave'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      voiceDuration: (json['voice_duration'] as num?)?.toDouble(),
      feelings: (json['feelings'] as List<dynamic>?)
          ?.map((e) => Feeling.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
      'text': instance.text,
      'title': instance.title,
      'created': instance.created?.toIso8601String(),
      'modified': instance.modified?.toIso8601String(),
      'identifier': instance.identifier,
      'user': instance.user,
      'publication_status': instance.publicationStatus,
      'dream_clearance': instance.dreamClearance,
      'dream_clearance_display': instance.dreamClearanceDisplay,
      'dream_date': instance.dreamDate?.toIso8601String(),
      'elements': instance.elements,
      'feelings': instance.feelings,
      'voice': instance.voice,
      'voice_duration': instance.voiceDuration,
      'voice_wave': instance.voiceWave,
    };
