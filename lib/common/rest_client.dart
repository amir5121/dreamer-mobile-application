import 'package:dio/dio.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/configurations/configurations.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/utils/configurations/")
  Future<Configurations> getConfigurations();

  @POST("/auth/jwt/create/")
  Future<AuthTokens> loginWithPassword(
      @Body() LoginCredentials loginCredentials);
}
