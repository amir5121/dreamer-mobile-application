import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class User {
  final String username;
  final String firstName;
  final String lastName;
  final String dateJoined;
  final String email;
  final String identifier;
  final String avatarImage;
  final String fullName;

  User(this.username, this.firstName, this.lastName, this.dateJoined,
      this.email, this.identifier, this.avatarImage, this.fullName);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
