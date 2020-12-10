import 'package:json_annotation/json_annotation.dart';

part 'ignore_data.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class IgnoreData {
  final String messageCode;
  final String message;
  final int code;

  IgnoreData(this.messageCode, this.message, this.code);

  factory IgnoreData.fromJson(Map<String, dynamic> json) => _$IgnoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$IgnoreDataToJson(this);
}
