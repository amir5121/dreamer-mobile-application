import 'package:dreamer/models/login.dart';
import 'package:dreamer/services/auth/auth_service.dart';
import 'package:dreamer/services/service_locator.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;

  final AuthService _authService = serviceLocator<AuthService>();

  Login _login;

  void loginWithPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    _login = await _authService.loginWithPassword(email, password);
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  Login get login {
    return _login;
  }
}
