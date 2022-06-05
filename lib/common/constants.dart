import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

class Constants {
  // adb reverse tcp:8000 tcp:8000
  static String baseUrl = isInDebugMode
      ? "http://localhost:8000/api/v1"
      : "https://dreamer.wisl.in/api/v1";

  static const int _deepPurplePrimaryValue = 0xFF7837D9;
  static const int maxFeelingSlider = 10;

  static const MaterialColor accentColor = Colors.grey;
  static const Color tertiaryColor = Color(0xFFECEFF1);

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

  static const String INVALID_GRANT = "invalid_grant";
  static const String INVALID_TOKEN = "token_not_valid";
  static const String NOT_FOUND = "not_found";
  static const String CONNECTION_FAILURE = "connection_failure";

  static const String ELEMENT_PLACE = 'place';
  static const String ELEMENT_OBJECT = 'object';
  static const String ELEMENT_CHARACTER = 'character';

  static const String ACCESS_TOKEN = 'accessToken';
  static const String REFRESH_TOKEN = 'refreshToken';
  static const String CLIENT_ID = 'NgVb5mLs2yXfSzg0lJtoWSai6LdtZRheUgC5sWhX';
  static const String CLIENT_SECRET =
      '1NnRa682BufFhBjSVyrPqm3ElErDpIGpj6fH7fynF1p7PzWd8R4g4jzhvODTcQqbxO3RwFnuEFIhBLaCA4ZMzxDUE11TyVRUFdYMKF7JK5kYpqojqyMvQ3mx10oBydBI';

  static String get platform {
    if (kIsWeb) {
      return "web";
    } else {
      if (Platform.isAndroid) {
        return "android";
      } else if (Platform.isIOS) {
        return "ios";
      } else if (Platform.isFuchsia) {
        return "fuchsia";
      } else if (Platform.isLinux) {
        return "linux";
      } else if (Platform.isMacOS) {
        return "mac";
      } else if (Platform.isWindows) {
        return "windows";
      }
      return "unknown";
    }
  }
}
