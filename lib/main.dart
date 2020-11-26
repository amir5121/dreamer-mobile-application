import 'package:dreamer/common/theme.dart';
import 'package:dreamer/screens/cart.dart';
import 'package:dreamer/screens/catalog.dart';
import 'package:dreamer/screens/login.dart';
import 'package:dreamer/screens/splash.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'models/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConfigurationsViewModel model = ConfigurationsViewModel();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => model),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),

        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
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
