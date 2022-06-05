// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeelingDetail _$FeelingDetailFromJson(Map<String, dynamic> json) =>
    FeelingDetail(
      json['description'] as String?,
      json['detailed_type'] as String?,
      json['parent_type'] as String?,
    );

Map<String, dynamic> _$FeelingDetailToJson(FeelingDetail instance) =>
    <String, dynamic>{
      'description': instance.description,
      'detailed_type': instance.detailedType,
      'parent_type': instance.parentType,
    };
