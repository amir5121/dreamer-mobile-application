import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';

class ConfigurationsViewModel extends RequestNotifier {
  bool _isLoading = true;
  ConfigurationsResponse _configurations;

  void loadData() async {
    _configurations = await makeRequest(
      () => Singleton().client.getConfigurations(),
    );
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  ConfigurationsResponse get configurations {
    return _configurations;
  }
}
