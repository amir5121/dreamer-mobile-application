import 'package:dreamer/common/request_notifier.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'configurations_view_model.dart';

class FirebaseMessagingViewModel extends RequestNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final ConfigurationsViewModel _configurationsViewModel;

  FirebaseMessagingViewModel(this._configurationsViewModel) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void gainPermission() async {
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void submitToken() async {
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      assert(_configurationsViewModel.configurations.data.self != null);
      print("Push Messaging token: $token");
    });
  }
}
