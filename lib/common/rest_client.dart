import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dreamer/models/analytics/analytics_response.dart';
import 'package:dreamer/models/auth/auth_tokens.dart';
import 'package:dreamer/models/auth/convert_token.dart';
import 'package:dreamer/models/auth/login_credentials.dart';
import 'package:dreamer/models/auth/logout_credentials.dart';
import 'package:dreamer/models/auth/sign_up_credentials.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_response.dart';
import 'package:dreamer/models/dream/dream_retrieve.dart';
import 'package:dreamer/models/dream/notifications_response.dart';
import 'package:dreamer/models/notification/notification_register.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/models/post/post_retrieve.dart';
import 'package:dreamer/models/utils/ignore_data.dart';
import 'package:dreamer/models/utils/upload_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/auth/token/")
  Future<AuthTokens> loginWithPassword(@Body() LoginCredentials loginCredentials);

  @POST("/auth/convert-token/")
  Future<AuthTokens> convertToken(@Body() ConvertToken loginCredentials);

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
    @Query("show_multi") required bool showMulti,
    @Query("page") int? page,
  });

  @GET("/post/timeline/{id}/")
  Future<PostRetrieve> getPost({
    @Path("id") required int id,
  });

  @GET("/post/dreams/")
  Future<DreamResponse> getDreams({
    @Query("page") required int page,
  });

  @GET("/notification/notifications/")
  Future<NotificationResponse> getNotifications({
    @Query("page") required int page,
  });

  @GET("/post/dreams/{identifier}/")
  Future<DreamRetrieve> getDream({
    @Path("identifier") required String identifier,
  });

  @DELETE("/post/dreams/{identifier}/")
  Future<IgnoreData> deleteDream({
    @Path("identifier") required String identifier,
  });

  @PATCH("/post/dreams/{identifier}/")
  Future<IgnoreData> updateDream(
      {@Path("identifier") required String identifier,
      @Body() required Dream dream});

  @POST("/post/dreams/")
  Future<IgnoreData> submitDream({@Body() required Dream dream});

  @POST("/devices/")
  Future<IgnoreData> registerToken(
    @Body() NotificationRegister user,
  );

  @POST("/utils/upload/")
  Future<UploadResponse> uploadFile(
    @Part(name: "file") File uploadFile,
  );

  @GET("/post/analytics/")
  Future<AnalyticsResponse> getAnalytics(
    @Query("duration") int duration,
  );
}
