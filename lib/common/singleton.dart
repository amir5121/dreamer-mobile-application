import 'package:dio/dio.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/rest_client.dart';
import 'package:dreamer/common/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  final Dio _dio;
  final RetryOptions _retry;
  RestClient _client;

  factory Singleton() {
    return _singleton;
  }

  RestClient get client => _client;

  RetryOptions get retry => _retry;

  Singleton._internal()
      : this._dio = Dio()
          ..options.baseUrl = Constants.baseUrl
          ..options.followRedirects = false
          ..options.validateStatus = ((status) => status < 300),
        _retry = RetryOptions(maxAttempts: 5) {
    this._client = RestClient(this._dio);

    Dio refreshDio = Dio();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          String accessToken = await DreamerStorage().read(key: Constants.ACCESS_TOKEN);
          if (accessToken == null) return options;
          String authorizationToken = "Bearer $accessToken";
          options.headers["Authorization"] = authorizationToken;
          return options;
        },
        onError: (DioError e) async {
          if (e.response != null && e.response.statusCode == 401) {
            debugPrint("asking for refresh token... LOCKING");
            _dio.interceptors.requestLock.lock();
            try {
              Response refreshResponse = await refreshDio.post(
                Constants.baseUrl + '/auth/token/',
                data: {
                  "refresh_token": await DreamerStorage().read(
                    key: Constants.REFRESH_TOKEN,
                  ),
                  "grant_type": "refresh_token",
                  "client_id": Constants.CLIENT_ID,
                  "client_secret": Constants.CLIENT_SECRET,
                },
              );

              DreamerStorage().write(
                  key: Constants.ACCESS_TOKEN, value: refreshResponse.data["access"]);
            } on DioError catch (_) {
              debugPrint("Failed to acquire token $_");
            } finally {
              _dio.interceptors.requestLock.unlock();
            }
          }
          return e;
        },
      ),
    );
  }
}
