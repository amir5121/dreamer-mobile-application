import 'package:flutter/cupertino.dart';

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String dateJoined;
  final String email;
  final String identifier;

  User(
      {@required this.username,
      @required this.firstName,
      @required this.lastName,
      @required this.dateJoined,
      @required this.email,
      @required this.identifier});
}
