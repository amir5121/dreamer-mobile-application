import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feeling.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Feeling {
  int rate;
  String feeling;
  final String feelingParent;

  Feeling({@required this.rate, @required this.feeling, @required this.feelingParent});

  factory Feeling.fromJson(Map<String, dynamic> json) => _$FeelingFromJson(json);

  Map<String, dynamic> toJson() => _$FeelingToJson(this);

  String feelingDisplay() {
    return feeling.substring(feeling.indexOf("_") + 1).capitalize();
  }
}
