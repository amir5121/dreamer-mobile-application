// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configurations _$ConfigurationsFromJson(Map<String, dynamic> json) {
  return Configurations(
    json['self'] == null
        ? null
        : User.fromJson(json['self'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConfigurationsToJson(Configurations instance) =>
    <String, dynamic>{
      'self': instance.self,
    };
