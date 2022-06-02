import 'package:json_annotation/json_annotation.dart';

part 'feeling_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeelingDetail {
  final String description;
  final String detailedType;
  final String parentType;

  FeelingDetail(this.description, this.detailedType, this.parentType);

  factory FeelingDetail.fromJson(Map<String, dynamic> json) =>
      _$FeelingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingDetailToJson(this);

}
