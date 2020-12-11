import 'package:json_annotation/json_annotation.dart';

part 'dream_clearance.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class DreamClearance {
  final int value;
  final String label;

  DreamClearance(this.value, this.label);

  factory DreamClearance.fromJson(Map<String, dynamic> json) =>
      _$DreamClearanceFromJson(json);

  Map<String, dynamic> toJson() => _$DreamClearanceToJson(this);
}
