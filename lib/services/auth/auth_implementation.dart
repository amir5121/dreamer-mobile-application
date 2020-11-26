import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/login.dart';
import 'package:dreamer/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<Login> loginWithPassword(email, password) async {
    final authResult = await Singleton().dio.post(
      "/auth/jwt/create/",
      data: {"email": email, "password": password},
    );
    print(authResult.data);
    return Login(accessToken: authResult.data['access'],
        refreshToken: authResult.data['refresh']);
  }
}
