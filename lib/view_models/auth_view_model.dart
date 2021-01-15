import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/common/storage.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/logout_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/ignore_data.dart';

class AuthViewModel extends RequestNotifier {
  AuthTokens _login;
  bool hasLoggedOut = false;

  Future<AuthViewModel> loginWithPassword(String email, String password) async {
    _login = await makeRequest<AuthTokens>(
      () => Singleton().client.loginWithPassword(
            LoginCredentials(
              email,
              password,
              Constants.CLIENT_ID,
              Constants.CLIENT_SECRET,
              "password",
            ),
          ),
    );

    DreamerStorage().write(key: Constants.ACCESS_TOKEN, value: _login?.accessToken);
    DreamerStorage().write(key: Constants.REFRESH_TOKEN, value: _login?.refreshToken);
    return this;
  }

  Future<AuthViewModel> logout() async {
    await makeRequest<void>(
      () async => Singleton()
          .client
          .logout(
            LogoutCredentials(
              await DreamerStorage().read(key: Constants.ACCESS_TOKEN),
              Constants.CLIENT_ID,
              Constants.CLIENT_SECRET,
            ),
          )
          .then((_) {
        DreamerStorage().delete(key: Constants.ACCESS_TOKEN);
        DreamerStorage().delete(key: Constants.REFRESH_TOKEN);
        hasLoggedOut = true;
        _login = null;
        notifyListeners();
      }),
    );
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
