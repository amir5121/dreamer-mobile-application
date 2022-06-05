// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPagination _$NotificationPaginationFromJson(
        Map<String, dynamic> json) =>
    NotificationPagination(
      json['next'] as String?,
      json['previous'] as String?,
      (json['results'] as List<dynamic>)
          .map((e) => DreamerNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationPaginationToJson(
        NotificationPagination instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
