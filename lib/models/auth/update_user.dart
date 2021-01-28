import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class UpdateUser {
  final String lastName;
  final String gender;
  String avatar;
  final DateTime birthDate;
  final _dateFormatter = new DateFormat('yyyy-M-dd');

  UpdateUser(this.lastName, this.gender, this.birthDate, this.avatar);

  factory UpdateUser.fromJson(Map<String, dynamic> json) => _$UpdateUserFromJson(json);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userJson = _$UpdateUserToJson(this);
    if (this.birthDate != null)
      userJson.update("birth_date", (_) => _dateFormatter.format(this.birthDate));
    return userJson;
  }
}
