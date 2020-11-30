import 'package:dreamer/models/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_pagination.g.dart';

@JsonSerializable()
class PostPagination {
  final String next;
  final String previous;
  final List<Post> result;

  PostPagination(this.next, this.previous, this.result);

  factory PostPagination.fromJson(Map<String, dynamic> json) =>
      _$PostPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaginationToJson(this);
}
