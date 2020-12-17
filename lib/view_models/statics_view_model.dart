import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/analytics/analytics_response.dart';

class StaticsViewModel extends RequestNotifier {
  AnalyticsResponse _statics;

  void loadStatics(int duration) async {
    _statics = await makeRequest(
      () => Singleton().client.getAnalytics(duration),
    );
  }

  AnalyticsResponse get statics {
    return _statics;
  }
}
