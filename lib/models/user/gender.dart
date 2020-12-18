import 'package:json_annotation/json_annotation.dart';

part 'gender.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Gender {
  final String value;
  final String label;

  Gender(this.value, this.label);

  factory Gender.fromJson(Map<String, dynamic> json) =>
      _$GenderFromJson(json);

  Map<String, dynamic> toJson() => _$GenderToJson(this);

}
