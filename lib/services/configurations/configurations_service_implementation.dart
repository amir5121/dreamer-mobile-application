import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/configurations.dart';
import 'package:dreamer/models/user.dart';
import 'package:dreamer/services/configurations/configurations_service.dart';

class ConfigurationsServiceImpl implements ConfigurationService {
  @override
  Future<Configurations> getConfigurations() async {
    final configs = await Singleton().dio.get("/utils/configurations/");
    final self = configs.data["data"]["self"];
    if (self == null) return Configurations();
    return Configurations(
        self: User(
            username: self["username"],
            firstName: self["first_name"],
            lastName: self["last_name"],
            dateJoined: self["date_joined"],
            email: self["email"],
            identifier: self["identifier"]));
  }
}
