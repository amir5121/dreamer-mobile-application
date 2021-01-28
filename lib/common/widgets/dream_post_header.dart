import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

import 'dreamer_dialog.dart';

class DreamPostHeader extends StatelessWidget {
  final Dream dream;

  const DreamPostHeader({Key key, this.dream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // child: Text("Dreamer"),
                    radius: 24,
                    backgroundImage: NetworkImage(
                      dream.user.avatar,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dream.user.fullName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          dream.user.email,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  showDreamDialog(
                    context,
                    child: Column(
                      children: [
                        FlatButton(
                          child: Text("Edit Dream"),
                          onPressed: () {
                            print("edddddditttt");
                          },
                        ),
                        FlatButton(
                          child: Text("Delete Dream"),
                          onPressed: () {
                            print("deleeeeteeee");
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Text(
                dream.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                dream.createdFormatted,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
