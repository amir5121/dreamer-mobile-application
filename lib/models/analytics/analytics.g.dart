// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) {
  return Analytics(
    json['main_quote'] as String,
    json['word_cloud'] as String,
  );
}

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'main_quote': instance.mainQuote,
      'word_cloud': instance.wordCloud,
    };
