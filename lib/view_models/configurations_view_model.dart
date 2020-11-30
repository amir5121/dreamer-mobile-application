import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';

class ConfigurationsViewModel extends RequestNotifier {
  ConfigurationsResponse _configurations;

  void loadData() async {
    _configurations = await makeRequest(
      () => Singleton().client.getConfigurations(),
    );
  }

  ConfigurationsResponse get configurations {
    return _configurations;
  }
}
