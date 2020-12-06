import 'package:json_annotation/json_annotation.dart';

part 'feeling.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Feeling {
  final int rate;
  final String type;

  Feeling(this.rate, this.type);

  factory Feeling.fromJson(Map<String, dynamic> json) => _$FeelingFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingToJson(this);
}
