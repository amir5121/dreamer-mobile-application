import 'package:flutter/material.dart';

class Constants {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String baseUrl = "http://10.0.2.2:8000/api/v1";

  static const int _deepPurplePrimaryValue = 0xFF7837D9;

  static const MaterialColor accentColor = Colors.grey;
  static const Color tertiaryColor = Colors.white;

  static const MaterialColor deepPurple = MaterialColor(
    _deepPurplePrimaryValue,
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(_deepPurplePrimaryValue),
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF1F182E),
    },
  );
  static const Color secondaryColor = Color(_deepPurplePrimaryValue);
}
