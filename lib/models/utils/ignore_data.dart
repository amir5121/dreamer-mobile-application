import 'package:json_annotation/json_annotation.dart';

part 'ignore_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IgnoreData {
  final String messageCode;
  final String message;

  IgnoreData(this.messageCode, this.message);

  factory IgnoreData.fromJson(Map<String, dynamic> json) => _$IgnoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$IgnoreDataToJson(this);
}
