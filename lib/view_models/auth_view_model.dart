import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/common/storage.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/ignore_data.dart';

class AuthViewModel extends RequestNotifier {
  AuthTokens _login;
  bool hasLoggedOut = false;

  Future<AuthViewModel> loginWithPassword(String email, String password) async {
    _login = await makeRequest<AuthTokens>(
      () => Singleton().client.loginWithPassword(
            LoginCredentials(email, password),
          ),
    );

    DreamerStorage().write(key: Constants.accessToken, value: _login.accessToken);
    DreamerStorage().write(key: Constants.refreshToken, value: _login.refreshToken);
    return this;
  }

  Future<AuthViewModel> logout() async {
    DreamerStorage().delete(key: Constants.accessToken);
    DreamerStorage().delete(key: Constants.refreshToken);
    hasLoggedOut = true;
    _login = null;
    notifyListeners();
    return this;
  }

  void signUpWithPassword(String email, String password, String rePassword) async {
    await makeRequest<IgnoreData>(
      () => Singleton().client.signUpWithPassword(
            SignUpCredentials(email, password, rePassword),
          ),
    );
  }

  Future<void> updateSelf(UpdateUser user) async {
    return await makeRequest<IgnoreData>(
      () => Singleton().client.updateSelf(
            user,
          ),
    );
  }

  void reset() {
    super.reset();
    _login = null;
  }

  AuthTokens get login {
    return _login;
  }
}
