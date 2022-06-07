// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRegister _$NotificationRegisterFromJson(
        Map<String, dynamic> json) =>
    NotificationRegister(
      json['registration_id'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$NotificationRegisterToJson(
        NotificationRegister instance) =>
    <String, dynamic>{
      'registration_id': instance.registrationId,
      'type': instance.type,
    };
