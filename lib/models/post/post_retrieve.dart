import 'package:dreamer/models/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_retrieve.g.dart';

@JsonSerializable()
class PostRetrieve {
  final String messageCode;
  final String message;
  final int code;
  final Post data;

  PostRetrieve(this.messageCode, this.message, this.code, this.data);

  factory PostRetrieve.fromJson(Map<String, dynamic> json) =>
      _$PostRetrieveFromJson(json);

  Map<String, dynamic> toJson() => _$PostRetrieveToJson(this);
}
