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
          String accessToken = await DreamerStorage().read(key: Constants.accessToken);
          if (accessToken == null) return options;
          String authorizationToken = "JWT $accessToken";
          options.headers["Authorization"] = authorizationToken;
          return options;
        },
        onError: (DioError e) async {
          if (e.response != null &&
              e.response.statusCode == 401 &&
              e.response.data['errors']['code'] == 'token_not_valid') {
            debugPrint("asking for refresh token... LOCKING");
            _dio.interceptors.requestLock.lock();
            try {
              Response refreshResponse = await refreshDio.post(
                Constants.baseUrl + '/auth/jwt/refresh/',
                data: {
                  "refresh": await DreamerStorage().read(key: Constants.refreshToken)
                },
              );

              DreamerStorage().write(
                  key: Constants.accessToken, value: refreshResponse.data["access"]);
            } on DioError catch (_) {
              debugPrint("Failed to acquire token");
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
