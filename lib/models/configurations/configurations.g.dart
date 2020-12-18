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
    json['main_background'] as String,
    (json['feelings'] as List)
        .map((e) => FeelingDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['main_feelings'] as List)
        .map((e) => FeelingDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['clearance_choices'] as List)
        .map((e) => DreamClearance.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['gender_choices'] as List)
        .map((e) => Gender.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConfigurationsToJson(Configurations instance) =>
    <String, dynamic>{
      'self': instance.self,
      'main_background': instance.mainBackground,
      'feelings': instance.feelings,
      'main_feelings': instance.mainFeelings,
      'clearance_choices': instance.clearanceChoices,
      'gender_choices': instance.genderChoices,
    };
