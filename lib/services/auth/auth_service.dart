import 'package:dreamer/models/login.dart';

abstract class AuthService {
  Future<Login> loginWithPassword(email, password);
}
