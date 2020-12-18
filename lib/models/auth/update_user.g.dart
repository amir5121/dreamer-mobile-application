// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUser _$UpdateUserFromJson(Map<String, dynamic> json) {
  return UpdateUser(
    json['last_name'] as String,
    json['gender'] as String,
    json['birth_date'] == null
        ? null
        : DateTime.parse(json['birth_date'] as String),
  );
}

Map<String, dynamic> _$UpdateUserToJson(UpdateUser instance) =>
    <String, dynamic>{
      'last_name': instance.lastName,
      'gender': instance.gender,
      'birth_date': instance.birthDate?.toIso8601String(),
    };
