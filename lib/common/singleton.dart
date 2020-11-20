import 'package:dio/dio.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  final Dio _dio;

  factory Singleton() {
    return _singleton;
  }

  Dio get dio => _dio;

  Singleton._internal()
      : this._dio = Dio()..options.baseUrl = "http://10.0.2.2:8000";
// ..options.connectTimeout = 5000
// ..options.receiveTimeout = 3000;
}
