// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamElement _$DreamElementFromJson(Map<String, dynamic> json) {
  return DreamElement(
    type: json['type'] as String,
    elements: (json['elements'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$DreamElementToJson(DreamElement instance) =>
    <String, dynamic>{
      'type': instance.type,
      'elements': instance.elements,
    };
