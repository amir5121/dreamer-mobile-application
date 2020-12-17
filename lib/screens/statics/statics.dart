import 'package:dreamer/screens/statics/statics_page.dart';
import 'package:flutter/material.dart';

class Statics extends StatefulWidget {
  @override
  _StaticsState createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  static List<Widget> _widgetOptions = <Widget>[
    StaticsPage(duration: 7),
    StaticsPage(duration: 30),
    StaticsPage(duration: 7300),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        child: Column(
          children: [
            TabBar(tabs: <Tab>[
              Tab(text: "Last 7 days"),
              Tab(text: "Last 30 days"),
              Tab(text: "All time"),
            ]),
            Expanded(
              child: TabBarView(
                children: _widgetOptions,
              ),
            )
          ],
        ),
      ),
    );
  }
}
