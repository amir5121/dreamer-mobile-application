import 'package:dreamer/models/dream/dream_pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dream_response.g.dart';

@JsonSerializable()
class DreamResponse {
  final String? messageCode;
  final String? message;
  final int? code;
  final DreamPagination data;

  DreamResponse(this.messageCode, this.message, this.code, this.data);

  factory DreamResponse.fromJson(Map<String, dynamic> json) =>
      _$DreamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DreamResponseToJson(this);
}
