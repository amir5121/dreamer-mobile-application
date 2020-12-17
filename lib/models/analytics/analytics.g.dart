// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) {
  return Analytics(
    json['main_quote'] as String,
    json['word_cloud'] as String,
    (json['feelings'] as List)
        .map((e) => FeelingSummarize.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['dream_count'] as int,
  );
}

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'main_quote': instance.mainQuote,
      'word_cloud': instance.wordCloud,
      'feelings': instance.feelings,
      'dream_count': instance.dreamCount,
    };
