import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/widgets/dreamer_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationsViewModel configurations =
    context.watch<ConfigurationsViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (configurations.isLoading == false &&
          configurations.hasError == false) {
        if (configurations.configurations.self == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    });

    return DreamerScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<ConfigurationsViewModel>(
              builder: (context, configurations, child) =>
              configurations.hasError
                  ? Column(
                children: [
                  Text(
                    "Something wen't wrong",
                  ),
                  Text(
                    configurations.errorMessage,
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  ),
                ],
              )
                  : Column(
                children: [
                  Text(
                    "Hello there dreamer",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: LinearProgressIndicator(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
