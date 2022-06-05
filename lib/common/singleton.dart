import 'package:dio/dio.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/rest_client.dart';
import 'package:dreamer/common/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  // static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final Dio _dio;
  final RetryOptions _retry;
  late RestClient _client;

  factory Singleton() {
    return _singleton;
  }

  RestClient get client => _client;

  RetryOptions get retry => _retry;

  // FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  Singleton._internal()
      : this._dio = Dio()
          ..options.baseUrl = Constants.baseUrl
          ..options.followRedirects = false
          ..options.validateStatus = ((status) => status! < 300),
        _retry = RetryOptions(maxAttempts: 8) {
    this._client = RestClient(this._dio);
    Firebase.initializeApp().whenComplete(() {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("onMessage: $message ${message.data}");
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });
    });

    //     onMessage: (Map<String, dynamic> message) async {
    //       print("onMessage: $message");
    //     },
    //     onBackgroundMessage: myBackgroundMessageHandler,
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print("onLaunch: $message");
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print("onResume: $message");
    //     },
    //   );
    //   firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true),
    //   );
    //
    //   firebaseMessaging.onIosSettingsRegistered
    //       .listen((IosNotificationSettings settings) {
    //     print("Settings registered: $settings");
    //   });
    // }

    Dio refreshDio = Dio();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          String? accessToken =
              await DreamerStorage().read(key: Constants.ACCESS_TOKEN);
          if (accessToken == null) return handler.next(options);
          String authorizationToken = "Bearer $accessToken";
          options.headers["Authorization"] = authorizationToken;
          return handler.next(options);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          if (e.response != null && e.response?.statusCode == 401) {
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
                  key: Constants.ACCESS_TOKEN,
                  value: refreshResponse.data["access_token"]);
              DreamerStorage().write(
                  key: Constants.REFRESH_TOKEN,
                  value: refreshResponse.data["refresh_token"]);
            } on DioError catch (_) {
              debugPrint("Failed to acquire token $_");
            } finally {
              _dio.interceptors.requestLock.unlock();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

// static Future<dynamic> myBackgroundMessageHandler(
//     Map<String, dynamic> message) async {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//     print("AAAAAAAAAA $data");
//   }
//
//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//     print("AAAAAAAAAA $notification");
//   }

// Or do other work.

}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}
