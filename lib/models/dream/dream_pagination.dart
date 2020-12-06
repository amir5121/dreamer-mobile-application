import 'package:json_annotation/json_annotation.dart';

import 'dream.dart';

part 'dream_pagination.g.dart';

@JsonSerializable()
class DreamPagination {
  final String next;
  final String previous;
  final List<Dream> results;

  DreamPagination(this.next, this.previous, this.results);

  factory DreamPagination.fromJson(Map<String, dynamic> json) =>
      _$DreamPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$DreamPaginationToJson(this);
}
