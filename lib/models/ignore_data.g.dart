// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ignore_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IgnoreData _$IgnoreDataFromJson(Map<String, dynamic> json) {
  return IgnoreData(
    json['message_code'] as String,
    json['message'] as String,
    json['code'] as int,
  );
}

Map<String, dynamic> _$IgnoreDataToJson(IgnoreData instance) =>
    <String, dynamic>{
      'message_code': instance.messageCode,
      'message': instance.message,
      'code': instance.code,
    };
