import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationsViewModel configurationsResponse =
        context.watch<ConfigurationsViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (configurationsResponse.isLoading == false &&
          configurationsResponse.configurations != null) {
        if (configurationsResponse.hasError == false) {
          if (configurationsResponse.authenticatedUser == null) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            // Sentry.configureScope(
            //   // (scope) => scope.user = User(
            //   //   username: configurationsResponse.authenticatedUser.username,
            //   //   email: configurationsResponse.authenticatedUser.email,
            //   // ),
            // );
            Navigator.pushReplacementNamed(context, '/home');
          }
        } else if (configurationsResponse.errorCode == Constants.INVALID_TOKEN) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    });

    return DreamerScaffold(
      body: DreamConsumer<ConfigurationsViewModel>(
        builder: (context, configurations, child) => Center(
          child: Column(
            children: [
              Expanded(
                child: configurations.hasError
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Something wen't wrong",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              configurations.errorMessage,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.loop),
                            onPressed: () {
                              configurations.loadConfigurations(context);
                            },
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello there dreamer",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: LinearProgressIndicator(),
                          ),
                        ],
                      ),
              ),
              Text("Build ${configurations.buildNumber}"),
              Text("Version ${configurations.version}"),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
