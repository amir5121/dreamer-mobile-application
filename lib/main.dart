import 'package:dreamer/common/theme.dart';
import 'package:dreamer/screens/dream_detail.dart';
import 'package:dreamer/screens/edit_profile.dart';
import 'package:dreamer/screens/landing.dart';
import 'package:dreamer/screens/login.dart';
import 'package:dreamer/screens/notifications/notifications_screen.dart';
import 'package:dreamer/screens/post_detail.dart';
import 'package:dreamer/screens/questionnaire/story.dart';
import 'package:dreamer/screens/settings.dart';
import 'package:dreamer/screens/sign_up.dart';
import 'package:dreamer/screens/splash.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runDreamerApp();
  // isInDebugMode
  //     ? runDreamerApp()
  //     : await SentryFlutter.init(
  //         (options) {
  //           options.debug = isInDebugMode;
  //           options.dsn =
  //               'https://06f4ea19c399443889f37e1b87662903@sentry.stickergramapp.com//3';
  //         },
  //         appRunner: () => runDreamerApp(),
  //       );
}

void runDreamerApp() {
  return runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConfigurationsViewModel configurationsViewModel = ConfigurationsViewModel();

  @override
  void initState() {
    // analytics = FirebaseAnalytics.instance;
    // Singleton();
    configurationsViewModel.loadConfigurations(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => configurationsViewModel),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Dreamer',
        theme: appTheme,
        initialRoute: '/',
        navigatorObservers: [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Login(),
              );
            case '/home':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  if (arguments is int) return Landing(selectedIndex: arguments);
                  return Landing(selectedIndex: 0);
                },
              );
            case '/sign-up':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => SignUp(),
              );
            case '/notifications':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => NotificationsScreen(),
              );
            case '/settings':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Settings(),
              );
            case '/story':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Story(identifier: arguments),
              );
            case '/dream':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => DreamDetail(identifier: arguments),
              );
            case '/post':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => PostDetail(postId: arguments),
              );
            case '/edit-profile':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => EditProfile(),
              );
            default:
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Splash(),
              );
          }
        },
      ),
    );
  }
}
