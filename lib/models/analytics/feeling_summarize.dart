import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'feeling_summarize.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeelingSummarize {
  final String label;
  final double value;
  final String color;

  FeelingSummarize(this.label, this.value, this.color);

  factory FeelingSummarize.fromJson(Map<String, dynamic> json) =>
      _$FeelingSummarizeFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingSummarizeToJson(this);

  Color dartColor() {
    final buffer = StringBuffer();
    if (this.color.length == 6 || this.color.length == 7) buffer.write('ff');
    buffer.write(this.color.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
