import 'dart:math';

import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
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

  Widget _journalHeader(context, constraints, User user) {
    final double percentage =
        (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

    if (++index > Colors.primaries.length - 1) index = 0;
    double opacity = 1 - 2 * (1 - percentage);
    if (opacity.isNegative) opacity = 0;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.black12,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                  shape: CircleBorder(),
                ),
              ],
            ),
            Opacity(
              opacity: opacity,
              child: Container(
                width: double.infinity,
                height: 110,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                user.email,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlineButton(
                                child: Icon(Icons.settings),
                                onPressed: null,
                                shape: CircleBorder(
                                  side: BorderSide(),
                                ),
                              ),
                              OutlineButton(
                                padding: EdgeInsets.symmetric(horizontal: 32),
                                onPressed: () {},
                                child: Text(
                                  "Edit profile",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                // borderSide: BorderSide(
                                //   color: Colors.white,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Opacity(
          opacity: opacity,
          child: Container(
            margin: EdgeInsets.only(left: 16),
            child: CircleAvatar(
              // child: Text("Dreamer"),
              radius: 34 * percentage,
              backgroundImage: NetworkImage(
                user.avatarImage,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DreamConsumer<ConfigurationsViewModel>(
          builder: (context, configurations, child) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        configurations.configurations.data.mainBackground,
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  height: constraints.maxHeight,
                  child: SafeArea(
                    child: _journalHeader(
                        context, constraints, configurations.configurations.data.self),
                  ),
                ),
              ],
            );
          },
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
