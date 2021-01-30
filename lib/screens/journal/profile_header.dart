import 'dart:io';

import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  final bool inProfileEdit;
  final Function pickImage;

  ProfileHeader({this.pickImage, this.inProfileEdit = false});

  Widget _journalHeader(context, constraints, User user) {
    final double percentage =
        (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

    if (++index > Colors.primaries.length - 1) index = 0;
    double opacity = 1 - 3 * (1 - percentage);
    return Stack(
      children: [
        Column(
          mainAxisAlignment:
              inProfileEdit ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
          children: [
            if (!inProfileEdit)
              Align(
                alignment: Alignment.topLeft,
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.black12,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                  shape: CircleBorder(),
                ),
              ),
            if (!opacity.isNegative)
              inProfileEdit
                  ? Container(
                      color: Constants.deepPurple[900],
                      height: 75 * opacity,
                    )
                  : Opacity(
                      opacity: opacity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border(
                            bottom: BorderSide(width: 1, color: Constants.accentColor),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 8,
                            right: 8,
                            bottom: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ButtonTheme(
                                    minWidth: 0,
                                    child: OutlineButton(
                                      child: Icon(Icons.settings),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/settings');
                                      },
                                      shape: CircleBorder(
                                        side: BorderSide(),
                                      ),
                                    ),
                                  ),
                                  OutlineButton(
                                    padding: EdgeInsets.symmetric(horizontal: 32),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/edit-profile');
                                    },
                                    child: Text(
                                      "Edit profile",
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ],
                              ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
          ],
        ),
        AnimatedAlign(
          duration: Duration(milliseconds: 200),
          alignment: opacity > 0.8 ? Alignment.centerLeft : Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 8, top: 4),
            child: GestureDetector(
              onTap: () {
                inProfileEdit
                    ? pickImage()
                    : showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(user.avatar, fit: BoxFit.fitWidth),
                          ],
                        ),
                      );
              },
              child: CircleAvatar(
                // child: Text("Dreamer"),
                radius: opacity > 0.5 ? 34 : 24,
                backgroundImage: user.avatar.contains("http")
                    ? NetworkImage(
                        user.avatar,
                      )
                    : FileImage(File(user.avatar)),
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
                    ),
                  ),
                  height: constraints.maxHeight,
                  child: SafeArea(
                    child: _journalHeader(
                      context,
                      constraints,
                      configurations.authenticatedUser,
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
  double get maxExtent => inProfileEdit ? 150 : 230.0;

  @override
  double get minExtent => 80.0;
}
