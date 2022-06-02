// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      json['main_quote'] as String,
      json['word_cloud'] as String,
      (json['feelings'] as List<dynamic>)
          .map((e) => FeelingSummarize.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dreams_count'] as int,
      (json['clearances'] as List<dynamic>)
          .map((e) => ClearanceSummarize.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'main_quote': instance.mainQuote,
      'word_cloud': instance.wordCloud,
      'feelings': instance.feelings,
      'clearances': instance.clearances,
      'dreams_count': instance.dreamsCount,
    };
