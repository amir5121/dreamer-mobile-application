import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Singleton().dio.get("/utils/configurations/").then(
    //   (value) {
    //     print(value);
    //     Navigator.pushReplacementNamed(context, '/login');
    //   },
    // );
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
    return Column(
      children: [
        Text("Hello there dreamer"),
        Consumer<ConfigurationsViewModel>(
            builder: (context, configurations, child) =>
                configurations.configurations.self ??
                Text('\$${configurations.configurations.self.username}'))
      ],
    );
  }
}
