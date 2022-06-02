// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feeling _$FeelingFromJson(Map<String, dynamic> json) => Feeling(
      rate: json['rate'] as int,
      feeling: json['feeling'] as String,
      feelingParent: json['feeling_parent'] as String,
    );

Map<String, dynamic> _$FeelingToJson(Feeling instance) => <String, dynamic>{
      'rate': instance.rate,
      'feeling': instance.feeling,
      'feeling_parent': instance.feelingParent,
    };
