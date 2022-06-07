import 'package:dreamer/models/dream/dream_clearance.dart';
import 'package:dreamer/models/dream/feeling_detail.dart';
import 'package:dreamer/models/user/gender.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'configurations.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Configurations {
  final User? self;
  final String? mainBackground;
  final List<FeelingDetail> feelings;
  final List<FeelingDetail> mainFeelings;
  final List<DreamClearance> clearanceChoices;
  final List<Gender> genderChoices;

  Configurations(this.self, this.mainBackground, this.feelings,
      this.mainFeelings, this.clearanceChoices, this.genderChoices);

  factory Configurations.fromJson(Map<String, dynamic> json) {
    return _$ConfigurationsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigurationsToJson(this);
}
