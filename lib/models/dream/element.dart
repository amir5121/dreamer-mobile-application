import 'package:json_annotation/json_annotation.dart';

part 'element.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Element {
  final String type;
  final List<String> elements;

  Element(this.type, this.elements);

  factory Element.fromJson(Map<String, dynamic> json) => _$ElementFromJson(json);

  Map<String, dynamic> toJson() => _$ElementToJson(this);
}
