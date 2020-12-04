import 'dart:math';

import 'package:flutter/material.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: MyDynamicHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: 200,
                    color: Color(Random().nextInt(0xffffffff)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Color color = Colors.primaries[index];
        final double percentage =
            (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

        if (++index > Colors.primaries.length - 1) index = 0;
        print(percentage);

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
                  gradient: LinearGradient(colors: [Colors.blue, color])),
              height: constraints.maxHeight,
              child: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    value: percentage,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}
