import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Post {
  final int? id;
  final DateTime? created;
  final List<String>? text;

  Post(this.created, this.text, this.id);

  factory Post.empty() {
    return Post(null, null, null);
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
