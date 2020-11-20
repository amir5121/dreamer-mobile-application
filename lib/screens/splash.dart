import 'package:dreamer/common/singleton.dart';
import 'package:flutter/material.dart';
import 'package:dreamer/common/widgets.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Singleton().dio.get("/api/initial/").then(
      (value) {
        print(value);
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
    return Center(
      child: Text("Hello there dreamer"),
    );
  }
}
