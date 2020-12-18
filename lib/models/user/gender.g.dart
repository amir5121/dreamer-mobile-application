// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gender _$GenderFromJson(Map<String, dynamic> json) {
  return Gender(
    json['value'] as String,
    json['label'] as String,
  );
}

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };
