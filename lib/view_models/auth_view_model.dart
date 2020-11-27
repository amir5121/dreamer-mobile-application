import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';

class AuthViewModel extends RequestNotifier {
  AuthTokens _login;

  void loginWithPassword(String email, String password) async {
    _login = await makeRequest<AuthTokens>(
      () => Singleton().client.loginWithPassword(
            LoginCredentials(email, password),
          ),
    );
  }

  AuthTokens get login {
    return _login;
  }
}
