import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String username;
  final String? firstName;
  final String? lastName;
  final DateTime dateJoined;
  final DateTime? birthDate;
  final String? gender;
  final String? genderDisplay;
  final String email;
  final String identifier;
  String avatar;
  final String fullName;

  User(
      this.username,
      this.firstName,
      this.lastName,
      this.dateJoined,
      this.email,
      this.identifier,
      this.avatar,
      this.fullName,
      this.birthDate,
      this.gender,
      this.genderDisplay);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
