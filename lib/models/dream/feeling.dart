import 'package:flutter/cupertino.dart';
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
}
