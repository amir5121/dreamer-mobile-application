import 'package:dio/dio.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  final Dio _dio;

  factory Singleton() {
    return _singleton;
  }

  Dio get dio => _dio;

  Singleton._internal()
      : this._dio = Dio()..options.baseUrl = "http://10.0.2.2:8000/api/v1" {
    //   dio.interceptors
    //     .add(InterceptorsWrapper(onRequest: (Options options) async {
    //   // If no token, request token firstly and lock this interceptor
    //   // to prevent other request enter this interceptor.
    //   dio.interceptors.requestLock.lock();
    //   // We use a new Dio(to avoid dead lock) instance to request token.
    //   Response response = await tokenDio.get("/token");
    //   //Set the token to headers
    //   options.headers["token"] = response.data["data"]["token"];
    //   dio.interceptors.requestLock.unlock();
    //   return options; //continue
    // }));
  }
// ..options.connectTimeout = 5000
// ..options.receiveTimeout = 3000;

}
