import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/common/storage.dart';
import 'package:dreamer/models/configurations/configurations_response.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:package_info/package_info.dart';

class ConfigurationsViewModel extends RequestNotifier {
  ConfigurationsResponse? _configurations;
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  Future<void> loadBuildData() async {
    if (kIsWeb) {
      appName = "Dreamer";
      packageName = "null";
      version = "web";
      buildNumber = "web";
    } else {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    }
    debugPrint("loadBuildData $appName $packageName $version $buildNumber");
    notifyListeners();
  }

  void loadConfigurations(BuildContext context) async {
    if (buildNumber == null) await loadBuildData();
    debugPrint(
        "loadConfigurations $appName $packageName $version $buildNumber");
    if (buildNumber != null)
      _configurations = await makeRequest(
        () => Singleton().client.getConfigurations(buildNumber!),
      );

    if (this.errorStatus == 401) {
      DreamerStorage().delete(key: Constants.ACCESS_TOKEN);
      DreamerStorage().delete(key: Constants.REFRESH_TOKEN);
      Phoenix.rebirth(context);
    }
  }

  ConfigurationsResponse? get configurations {
    return _configurations;
  }

  User? get authenticatedUser {
    return _configurations?.data.self;
  }
}
