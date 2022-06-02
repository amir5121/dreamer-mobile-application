// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPagination _$PostPaginationFromJson(Map<String, dynamic> json) =>
    PostPagination(
      json['next'] as String,
      json['previous'] as String,
      (json['results'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostPaginationToJson(PostPagination instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
