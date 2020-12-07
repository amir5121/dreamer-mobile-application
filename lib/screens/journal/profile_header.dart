import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  Widget _journalHeader(context, constraints, User user) {
    final double percentage =
        (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

    if (++index > Colors.primaries.length - 1) index = 0;
    double opacity = 1 - 2 * (1 - percentage);
    return Stack(
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
            if (!opacity.isNegative)
              Opacity(
                opacity: opacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border(
                      bottom: BorderSide(width: 1, color: Constants.accentColor),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 35 - (1 - opacity) * 35),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/settings');
                                  },
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
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          right: opacity > 0.8 ? 310 : 0,
          top: opacity > 0.8 ? 70.0 : 0,
          // right: null,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 8, top: 4),
            child: CircleAvatar(
              // child: Text("Dreamer"),
              radius: opacity > 0.5 ? 34 : 24,
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
                      context,
                      constraints,
                      configurations.configurations.data.self,
                    ),
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
