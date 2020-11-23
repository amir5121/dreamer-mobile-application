import 'package:dreamer/common/theme.dart';
import 'package:dreamer/screens/cart.dart';
import 'package:dreamer/screens/catalog.dart';
import 'package:dreamer/screens/login.dart';
import 'package:dreamer/screens/splash.dart';
import 'package:dreamer/services/service_locator.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => ConfigurationsViewModel()),
      ],
      child: MaterialApp(
        title: 'Dreamer',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/login': (context) => Login(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
