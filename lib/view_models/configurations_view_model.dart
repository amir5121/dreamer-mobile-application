import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:package_info/package_info.dart';

class ConfigurationsViewModel extends RequestNotifier {
  ConfigurationsResponse _configurations;
  String appName;
  String packageName;
  String version;
  String buildNumber;

  Future<void> loadBuildData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    notifyListeners();
  }

  void loadConfigurations() async {
    if (buildNumber == null) await loadBuildData();
    _configurations = await makeRequest(
      () => Singleton().client.getConfigurations(buildNumber),
    );
  }

  ConfigurationsResponse get configurations {
    return _configurations;
  }
}
