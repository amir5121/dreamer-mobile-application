// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clearance_summarize.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClearanceSummarize _$ClearanceSummarizeFromJson(Map<String, dynamic> json) {
  return ClearanceSummarize(
    (json['average'] as num).toDouble(),
    DateTime.parse(json['day'] as String),
  );
}

Map<String, dynamic> _$ClearanceSummarizeToJson(ClearanceSummarize instance) =>
    <String, dynamic>{
      'average': instance.average,
      'day': instance.day.toIso8601String(),
    };
