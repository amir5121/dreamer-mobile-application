import 'package:dio/dio.dart';
import 'package:dreamer/models/login.dart';
import 'package:dreamer/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier  {
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  Login _login;

  void loginWithPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _login = await _authService.loginWithPassword(email, password);
    } on DioError catch(e) {
      if(e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else{
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
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
