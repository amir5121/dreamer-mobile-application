import 'package:flutter/material.dart';

AppBar dreamAppBar = AppBar(
  title: Text("Dreamer"),
  elevation: 0,
  centerTitle: true,
);

class DreamerScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final bool showAppBar;

  const DreamerScaffold({
    Key key,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.showAppBar ? dreamAppBar : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
