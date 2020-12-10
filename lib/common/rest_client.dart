import 'package:dio/dio.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:dreamer/models/dream/dream_response.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/jwt/create/")
  Future<AuthTokens> loginWithPassword(@Body() LoginCredentials loginCredentials);

  @POST("/auth/users/")
  Future<AuthTokens> signUpWithPassword(@Body() SignUpCredentials signUpCredentials);

  @GET("/configuration/initial/")
  Future<ConfigurationsResponse> getConfigurations(
    @Query("build_number") String buildNumber,
  );

  @GET("/post/timeline/")
  Future<PostResponse> getTimeline({
    @Query("show_multi") bool showMulti,
    @Query("page") int page,
  });

  @GET("/post/dreams/")
  Future<DreamResponse> getDreams({
    @Query("page") int page,
  });
}
