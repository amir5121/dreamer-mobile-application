// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feeling _$FeelingFromJson(Map<String, dynamic> json) {
  return Feeling(
    json['rate'] as int,
    json['type'] as String,
  );
}

Map<String, dynamic> _$FeelingToJson(Feeling instance) => <String, dynamic>{
      'rate': instance.rate,
      'type': instance.type,
    };
