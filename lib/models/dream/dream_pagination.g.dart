// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamPagination _$DreamPaginationFromJson(Map<String, dynamic> json) {
  return DreamPagination(
    json['next'] as String,
    json['previous'] as String,
    (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Dream.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DreamPaginationToJson(DreamPagination instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
