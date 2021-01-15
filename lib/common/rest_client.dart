import 'package:dio/dio.dart';
import 'package:dreamer/models/analytics/analytics_response.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/logout_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_response.dart';
import 'package:dreamer/models/dream/dream_retrieve.dart';
import 'package:dreamer/models/ignore_data.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/models/post/post_retrieve.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/token/")
  Future<AuthTokens> loginWithPassword(@Body() LoginCredentials loginCredentials);

  @POST("/auth/revoke-token/")
  Future<void> logout(@Body() LogoutCredentials loginCredentials);

  @POST("/auth/users/")
  Future<IgnoreData> signUpWithPassword(@Body() SignUpCredentials signUpCredentials);

  @PATCH("/auth/users/me/")
  Future<IgnoreData> updateSelf(@Body() UpdateUser user);

  @GET("/configuration/initial/")
  Future<ConfigurationsResponse> getConfigurations(
    @Query("build_number") String buildNumber,
  );

  @GET("/post/timeline/")
  Future<PostResponse> getTimeline({
    @Query("show_multi") bool showMulti,
    @Query("page") int page,
  });

  @GET("/post/timeline/{id}/")
  Future<PostRetrieve> getPost({
    @Path("id") int id,
  });

  @GET("/post/dreams/")
  Future<DreamResponse> getDreams({
    @Query("page") int page,
  });

  @GET("/post/dreams/{identifier}/")
  Future<DreamRetrieve> getDream({
    @Path("identifier") String identifier,
  });

  @POST("/post/dreams/")
  Future<IgnoreData> submitDream({@Body() Dream dream});

  @GET("/post/analytics/")
  Future<AnalyticsResponse> getAnalytics(
    @Query("duration") int duration,
  );
}
