import 'package:dreamer/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final appTheme = ThemeData(
    primarySwatch: Constants.deepPurple,
    brightness: Brightness.dark,
    accentColor: Colors.purpleAccent,
    errorColor: Colors.deepOrangeAccent,
    scaffoldBackgroundColor: Constants.deepPurple[900],
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.grey),
      subtitle1: TextStyle(color: Colors.grey),
      headline4: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.blueGrey),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(left: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        errorStyle: TextStyle(fontSize: 16)),
    appBarTheme: AppBarTheme(color: Constants.deepPurple[900]));
