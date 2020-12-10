import 'package:json_annotation/json_annotation.dart';

import 'feeling.dart';

part 'feeling_detail.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class FeelingDetail {
  final String description;
  final String detailedType;
  final String parentType;

  FeelingDetail(this.description, this.detailedType, this.parentType);

  factory FeelingDetail.fromJson(Map<String, dynamic> json) =>
      _$FeelingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingDetailToJson(this);

  Feeling convertToFeeling() =>
      Feeling(rate: 0, feeling: detailedType, feelingParent: parentType);
}
