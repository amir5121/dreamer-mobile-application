import 'package:dreamer/models/post/post_pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  final String messageCode;
  final String message;
  final int code;
  final PostPagination data;

  PostResponse(this.messageCode, this.message, this.code, this.data);

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
