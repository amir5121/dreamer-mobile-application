import 'package:dio/dio.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/rest_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as SecureStorage;
import 'package:retry/retry.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  final Dio _dio;
  final RetryOptions _retry;
  RestClient _client;

  factory Singleton() {
    return _singleton;
  }

  final _storage = SecureStorage.FlutterSecureStorage();

  RestClient get client => _client;

  RetryOptions get retry => _retry;

  Singleton._internal()
      : this._dio = Dio()
          ..options.baseUrl = Constants.baseUrl
          ..options.followRedirects = false
          ..options.validateStatus = ((status) => status < 300),
        _retry = RetryOptions() {
    this._client = RestClient(this._dio);

    Dio refreshDio = Dio();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          String accessToken = await _storage.read(key: Constants.accessToken);
          if (accessToken == null) return options;
          String authorizationToken = "JWT $accessToken";
          options.headers["Authorization"] = authorizationToken;
          return options;
        },
        onError: (DioError e) async {
          print(e.response.statusCode);
          print(e.response.data['errors']['code']);
          if (e.response.statusCode == 401 &&
              e.response.data['errors']['code'] == 'token_not_valid') {
            _dio.interceptors.requestLock.lock();

            Response refreshResponse = await refreshDio.post(
              Constants.baseUrl + '/auth/jwt/refresh/',
              data: {
                "refresh": await _storage.read(key: Constants.refreshToken)
              },
            );
            await _storage.write(
                key: Constants.accessToken,
                value: refreshResponse.data["access"]);
            _dio.interceptors.requestLock.unlock();
          }
          return e;
        },
      ),
    );
    // _dio.interceptors
    //     .add(InterceptorsWrapper(onRequest: (Options options) async {
    //   // If no token, request token firstly and lock this interceptor
    //   // to prevent other request enter this interceptor.
    //   _dio.interceptors.requestLock.lock();
    //   // We use a new Dio(to avoid dead lock) instance to request token.
    //   Response response = await tokenDio.get("/token");
    //   //Set the token to headers
    //   options.headers["token"] = response.data["data"]["token"];
    //   _dio.interceptors.requestLock.unlock();
    //   return options; //continue
    // }));
  }
}
