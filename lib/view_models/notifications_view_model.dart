import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/dream/notifications_response.dart';

class NotificationsViewModel extends RequestNotifier {
  NotificationResponse? _notifications;

  Future<NotificationsViewModel> loadNotifications(page) async {
    _notifications = await makeRequest(
      () => Singleton().client.getNotifications(page: page),
      notify: false,
    );
    return this;
  }

  NotificationResponse? get notifications {
    return _notifications;
  }
}
