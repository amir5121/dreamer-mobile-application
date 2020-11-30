import 'package:dio/dio.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/jwt/create/")
  Future<AuthTokens> loginWithPassword(
      @Body() LoginCredentials loginCredentials);

  @GET("/utils/configurations/")
  Future<ConfigurationsResponse> getConfigurations();

  @GET("/post/posts/")
  Future<PostResponse> getPosts(@Query("status") String status);
}
