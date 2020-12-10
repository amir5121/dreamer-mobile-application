import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final appTheme = ThemeData(
  primarySwatch: Constants.deepPurple,
  brightness: Brightness.dark,
  accentColor: Constants.accentColor,
  primaryColor: Constants.deepPurple[900],
  primaryColorDark: Constants.deepPurple,
  errorColor: Colors.deepOrangeAccent,
  scaffoldBackgroundColor: Constants.deepPurple[900],
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Constants.accentColor),
    subtitle1: TextStyle(color: Constants.accentColor),
    headline4: TextStyle(color: Constants.tertiaryColor),
    headline6: TextStyle(color: Constants.tertiaryColor),
    caption: TextStyle(color: Colors.blueGrey),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Constants.tertiaryColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Constants.deepPurple[900],
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    errorStyle: TextStyle(fontSize: 16),
  ),
  appBarTheme: AppBarTheme(
    color: Constants.deepPurple[900],
  ),
);
