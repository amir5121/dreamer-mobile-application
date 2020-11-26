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
      if (configurations.isLoading == false) {
        if (configurations.configurations.self == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushReplacementNamed(context, '/catalog');
        }
      }
    });

    return DreamerScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello there dreamer",
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: LinearProgressIndicator(),
          )

          // Consumer<ConfigurationsViewModel>(
          //     builder: (context, configurations, child) =>
          //         _buildChild(configurations))
        ],
      ),
    );
  }
}
