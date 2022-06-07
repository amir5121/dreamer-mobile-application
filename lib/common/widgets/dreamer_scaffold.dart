import 'package:dreamer/common/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DreamerScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final AppBar? appBar;
  final bool showAppBar;

  final AppBar dreamAppBar;

  DreamerScaffold({
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showAppBar = true,
    this.appBar,
    this.actions,
  })  : dreamAppBar = AppBar(
          title: SVGIcon(
            size: 21,
            color: Constants.secondaryColor,
            assetAddress: 'assets/images/icon_stretched.svg',
          ),
          elevation: 0,
          centerTitle: true,
          actions: actions,
        ),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.showAppBar
          ? appBar != null
              ? appBar
              : dreamAppBar
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
