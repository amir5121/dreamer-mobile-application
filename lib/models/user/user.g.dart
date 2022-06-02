// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['username'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      DateTime.parse(json['date_joined'] as String),
      json['email'] as String,
      json['identifier'] as String,
      json['avatar'] as String,
      json['full_name'] as String,
      DateTime.parse(json['birth_date'] as String),
      json['gender'] as String,
      json['gender_display'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_joined': instance.dateJoined.toIso8601String(),
      'birth_date': instance.birthDate.toIso8601String(),
      'gender': instance.gender,
      'gender_display': instance.genderDisplay,
      'email': instance.email,
      'identifier': instance.identifier,
      'avatar': instance.avatar,
      'full_name': instance.fullName,
    };
