import 'package:dreamer/models/configurations.dart';
import 'package:dreamer/services/configurations/configurations_service.dart';
import 'package:dreamer/services/service_locator.dart';
import 'package:flutter/foundation.dart';

class ConfigurationsViewModel extends ChangeNotifier {
  final ConfigurationService _configurationService =
      serviceLocator<ConfigurationService>();
  bool _isLoading = true;
  Configurations _configurations;

  void loadData() async {
    _configurations = await _configurationService.getConfigurations();
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  Configurations get configurations {
    return _configurations;
  }
}
