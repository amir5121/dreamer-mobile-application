import 'dart:io';

import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/common/storage.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/convert_token.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/logout_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/notification/notification_register.dart';
import 'package:dreamer/models/utils/ignore_data.dart';
import 'package:dreamer/models/utils/upload_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends RequestNotifier {
  AuthTokens? _login;
  bool hasLoggedOut = false;

  Future<AuthViewModel> logout() async {
    await makeRequest<void>(
      () async {
        String? accessToken =
            await DreamerStorage().read(key: Constants.ACCESS_TOKEN);
        if (accessToken != null)
          await Singleton().client.logout(
                LogoutCredentials(
                  accessToken,
                  Constants.CLIENT_ID,
                  Constants.CLIENT_SECRET,
                ),
              );
        DreamerStorage().delete(key: Constants.ACCESS_TOKEN);
        DreamerStorage().delete(key: Constants.REFRESH_TOKEN);
        hasLoggedOut = true;
        _login = null;
        notifyListeners();
        return;
      },
    );
    return this;
  }

  Future<AuthViewModel> signUpWithPassword(
      String email, String password, String rePassword) async {
    await makeRequest<IgnoreData>(
      () => Singleton().client.signUpWithPassword(
            SignUpCredentials(email, password, rePassword),
          ),
    );
    return this;
  }

  Future<IgnoreData?> updateSelf(UpdateUser user) async {
    if (user.avatar != null) {
      await makeRequest<UploadResponse>(
        () async => await Singleton().client.uploadFile(
              File(user.avatar!),
            ),
      ).then((UploadResponse? value) {
        if (!this.hasError) {
          user.avatar = value?.data.filePath;
        }
      });
    }
    if (!this.hasError)
      return await makeRequest<IgnoreData>(
        () => Singleton().client.updateSelf(
              user,
            ),
      );
  }

  Future<AuthViewModel> loginWithPassword(String email, String password) async {
    _login = await makeRequest<AuthTokens>(() => {
          Singleton().client.loginWithPassword(
                LoginCredentials(
                  email,
                  password,
                  Constants.CLIENT_ID,
                  Constants.CLIENT_SECRET,
                  "password",
                ),
              ),
        });
    saveLoginInfo();
    return this;
  }

  Future<AuthViewModel?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      _login = await makeRequest<AuthTokens>(
        () => {
          if (googleAuth.accessToken != null)
            Singleton().client.convertToken(
                  ConvertToken(
                    clientId: Constants.CLIENT_ID,
                    clientSecret: Constants.CLIENT_SECRET,
                    token: googleAuth.accessToken!,
                    backend: "google-oauth2",
                  ),
                )
        },
      );
      saveLoginInfo();
      return this;
    }
  }

  Future<AuthViewModel> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
    ]);
    FacebookAccessToken facebookAccessToken;
    switch (result.status) {
      case FacebookLoginStatus.success:
        if (result.accessToken != null) {
          facebookAccessToken = result.accessToken!;
          _login = await makeRequest<AuthTokens>(
            () => Singleton().client.convertToken(
                  ConvertToken(
                    clientId: Constants.CLIENT_ID,
                    clientSecret: Constants.CLIENT_SECRET,
                    token: facebookAccessToken.token,
                    backend: "facebook",
                  ),
                ),
          );
        }
        saveLoginInfo();
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        break;
    }
    return this;
  }

  void reset() {
    super.reset();
    _login = null;
  }

  void saveLoginInfo() {
    assert(_login != null);
    if (_login != null && _login!.accessToken != null) {
      submitToken();
      String? accessToken = _login?.accessToken;
      if (accessToken != null)
        DreamerStorage().write(key: Constants.ACCESS_TOKEN, value: accessToken);
      String? refreshToken = _login?.refreshToken;
      if (refreshToken != null)
        DreamerStorage()
            .write(key: Constants.REFRESH_TOKEN, value: refreshToken);
    }
  }

  AuthTokens? get login {
    return _login;
  }

  void submitToken() async {
    FirebaseMessaging.instance.getToken().then((String? token) async {
      assert(token != null);
      if (token != null)
        await makeRequest(() => Singleton().client.registerToken(
              NotificationRegister(
                token,
                Constants.platform,
              ),
            ));
    });
  }
}
