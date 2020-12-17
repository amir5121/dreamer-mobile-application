// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_summarize.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeelingSummarize _$FeelingSummarizeFromJson(Map<String, dynamic> json) {
  return FeelingSummarize(
    json['label'] as String,
    (json['value'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FeelingSummarizeToJson(FeelingSummarize instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };
