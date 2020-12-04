// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['date_joined'] as String,
    json['email'] as String,
    json['identifier'] as String,
    json['avatar_image'] as String,
    json['full_name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_joined': instance.dateJoined,
      'email': instance.email,
      'identifier': instance.identifier,
      'avatar_image': instance.avatarImage,
      'full_name': instance.fullName,
    };
