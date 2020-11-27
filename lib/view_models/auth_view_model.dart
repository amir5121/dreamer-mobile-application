import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthViewModel extends RequestNotifier {
  AuthTokens _login;

  void loginWithPassword(String email, String password) async {
    _login = await makeRequest<AuthTokens>(
      () => Singleton().client.loginWithPassword(
            LoginCredentials(email, password),
          ),
    );

    final storage = FlutterSecureStorage();

    await storage.write(key: Constants.accessToken, value: _login.accessToken);
    await storage.write(
        key: Constants.refreshToken, value: _login.refreshToken);
  }

  AuthTokens get login {
    return _login;
  }
}
