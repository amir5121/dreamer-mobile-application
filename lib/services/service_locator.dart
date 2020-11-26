import 'package:dreamer/services/auth/auth_implementation.dart';
import 'package:dreamer/services/auth/auth_service.dart';
import 'package:dreamer/services/configurations/configurations_service.dart';
import 'package:dreamer/services/configurations/configurations_service_implementation.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<ConfigurationService>(
      () => ConfigurationsServiceImpl());

  serviceLocator.registerLazySingleton<AuthService>(() => AuthServiceImpl());

  // fakes
  // serviceLocator.registerLazySingleton<ConfigurationService>(() => ConfigurationsServiceFake());

  // view models
  serviceLocator.registerFactory<ConfigurationsViewModel>(
      () => ConfigurationsViewModel());
  serviceLocator.registerFactory<AuthViewModel>(() => AuthViewModel());
}
