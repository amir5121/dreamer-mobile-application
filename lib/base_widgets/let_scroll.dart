import 'package:flutter/material.dart';

class _NoOverScrollAnimation extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class LetScroll extends StatelessWidget {
  final Widget child;

  const LetScroll({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _NoOverScrollAnimation(),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
