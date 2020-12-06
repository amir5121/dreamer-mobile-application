import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Post {
  final DateTime created;
  final List<String> text;

  Post(this.created, this.text);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
