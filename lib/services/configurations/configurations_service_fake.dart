import 'dart:async';

import 'package:dreamer/models/configurations.dart';
import 'package:dreamer/models/user.dart';
import 'package:dreamer/services/configurations/configurations_service.dart';

// This class is just used temporarily during the tutorial so that the app can
// run without crashing before the WebApi service is finished.
class ConfigurationsServiceFake implements ConfigurationService {
  @override
  Future<Configurations> getConfigurations() async {
    return Configurations(
        self: User(
      username: 'test',
      email: 'test@test.com',
    ));
  }
}
