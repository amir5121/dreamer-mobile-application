import 'package:dreamer/common/theme.dart';
import 'package:dreamer/screens/landing.dart';
import 'package:dreamer/screens/login.dart';
import 'package:dreamer/screens/questionnaire/story.dart';
import 'package:dreamer/screens/settings.dart';
import 'package:dreamer/screens/sign_up.dart';
import 'package:dreamer/screens/splash.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConfigurationsViewModel configurationsViewModel = ConfigurationsViewModel();

  @override
  void initState() {
    configurationsViewModel.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => configurationsViewModel),
        ChangeNotifierProvider(create: (context) => AuthViewModel())
      ],
      child: MaterialApp(
        title: 'Dreamer',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/login': (context) => Login(),
          '/home': (context) => Landing(),
          '/signup': (context) => SignUp(),
          '/settings': (context) => Settings(),
          '/story': (context) => Story(),
        },
      ),
    );
  }
}
