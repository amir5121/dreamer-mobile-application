import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/login.dart';

class AuthService {
  Future<Login> loginWithPassword(email, password) async {
    final authResult = await Singleton().dio.post(
      "/auth/jwt/create/",
      data: {"email": email, "password": password},
    );

    return Login(
        accessToken: authResult.data['access'],
        refreshToken: authResult.data['refresh']);
  }
}
