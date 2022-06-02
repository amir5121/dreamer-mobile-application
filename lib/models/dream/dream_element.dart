import 'package:json_annotation/json_annotation.dart';

part 'dream_element.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DreamElement {
  final String type;
  final List<String> elements;

  DreamElement({required this.type, required this.elements});

  factory DreamElement.fromJson(Map<String, dynamic> json) => _$DreamElementFromJson(json);

  Map<String, dynamic> toJson() => _$DreamElementToJson(this);
}
