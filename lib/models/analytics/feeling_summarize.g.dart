// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_summarize.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeelingSummarize _$FeelingSummarizeFromJson(Map<String, dynamic> json) =>
    FeelingSummarize(
      json['label'] as String,
      (json['value'] as num).toDouble(),
      json['color'] as String,
    );

Map<String, dynamic> _$FeelingSummarizeToJson(FeelingSummarize instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'color': instance.color,
    };
