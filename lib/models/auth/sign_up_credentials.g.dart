// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpCredentials _$SignUpCredentialsFromJson(Map<String, dynamic> json) =>
    SignUpCredentials(
      json['email'] as String,
      json['password'] as String,
      json['re_password'] as String,
    );

Map<String, dynamic> _$SignUpCredentialsToJson(SignUpCredentials instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      're_password': instance.rePassword,
    };
