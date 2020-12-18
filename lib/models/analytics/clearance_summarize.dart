import 'package:json_annotation/json_annotation.dart';

part 'clearance_summarize.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class ClearanceSummarize {
  final double average;
  final DateTime day;

  ClearanceSummarize(this.average, this.day);

  factory ClearanceSummarize.fromJson(Map<String, dynamic> json) =>
      _$ClearanceSummarizeFromJson(json);

  Map<String, dynamic> toJson() => _$ClearanceSummarizeToJson(this);
}
