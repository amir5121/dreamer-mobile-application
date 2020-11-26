import 'dart:async';

import 'package:dreamer/models/login.dart';
import 'package:dreamer/services/auth/auth_service.dart';

class AuthServiceFake implements AuthService {
  @override
  Future<Login> loginWithPassword(email, password) async {
    return Login(accessToken: null, refreshToken: null);
  }
}
