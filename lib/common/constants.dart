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
  // static const String baseUrl = "http://10.0.2.2:8000/api/v1";
  // static const String baseUrl = "http://localhost:8000/api/v1";
  // static const String baseUrl = "https://amir.jprq.live/api/v1";
  static String baseUrl = isInDebugMode
      ? "http://10.0.2.2:8000/api/v1"
      : "https://dreamer.stickergramapp.com/api/v1";

  // static String baseUrl =  "https://serious-cat-38.loca.lt/api/v1";
  // static String baseUrl = "https://dreamer.stickergramapp.com/api/v1";

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

  static const String ACCESS_TOKEN = 'accessToken';
  static const String REFRESH_TOKEN = 'refreshToken';
  static const String CLIENT_ID = 'gm57SXQ1djmgk12Rs32EnDzc2AQMpsJbGHQ8CJpT';
  static const String CLIENT_SECRET =
      'odbNmDwkbWmbVecFsyv7XRTfykd1bXKFXgFBo6mO5X3u1idELwAd8pGpwFdNbv35sPTXNzFIWiYxOPot2u2CmbfKKrYbKABslrNV2UdFZn2Hl1DNc7r316eYJCprpuDd';

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
