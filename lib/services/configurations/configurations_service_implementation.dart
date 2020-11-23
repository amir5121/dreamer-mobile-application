import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/configurations.dart';
import 'package:dreamer/models/user.dart';
import 'package:dreamer/services/configurations/configurations_service.dart';

class ConfigurationsServiceImpl implements ConfigurationService {
  @override
  Future<Configurations> getConfigurations() async {
    final configs = await Singleton().dio.get("/utils/configurations/");
    return Configurations(
        self: User(
            username: configs.data["data"]["username"],
            firstName: configs.data["data"]["first_name"],
            lastName: configs.data["data"]["last_name"],
            dateJoined: configs.data["data"]["date_joined"],
            email: configs.data["data"]["email"],
            identifier: configs.data["data"]["identifier"]));
  }
}
