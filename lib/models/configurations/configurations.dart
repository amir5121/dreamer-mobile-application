import 'package:dreamer/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'configurations.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Configurations {
  @JsonKey(nullable: true)
  final User self;

  Configurations(this.self);

  factory Configurations.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationsFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationsToJson(this);
}
