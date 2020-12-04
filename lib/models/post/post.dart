import 'package:dreamer/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'post.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Post {
  final User user;
  final DateTime created;
  final String modified;
  final String status;
  final List<String> text;
  final String identifier;

  Post(this.user, this.created, this.modified, this.status, this.text, this.identifier);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  String get createdFormatted {
    return timeago.format(created, locale: 'en_short');
  }
}
