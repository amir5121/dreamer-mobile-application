import 'package:json_annotation/json_annotation.dart';

part 'feeling_summarize.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class FeelingSummarize {
  final String label;
  final double value;

  FeelingSummarize(this.label, this.value);

  factory FeelingSummarize.fromJson(Map<String, dynamic> json) =>
      _$FeelingSummarizeFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingSummarizeToJson(this);
}
