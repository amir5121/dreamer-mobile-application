import 'package:dreamer/models/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_pagination.g.dart';

@JsonSerializable()
class PostPagination {
  final String next;
  final String previous;
  final List<Post> results;

  PostPagination(this.next, this.previous, this.results);

  factory PostPagination.fromJson(Map<String, dynamic> json) =>
      _$PostPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaginationToJson(this);
}
