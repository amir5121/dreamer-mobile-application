import 'package:dreamer/common/constants.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

Widget dreamItem(Dream dream, context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      border: Border(
        bottom: BorderSide(width: 1, color: Constants.accentColor),
      ),
    ),
    padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // child: Text("Dreamer"),
                    radius: 24,
                    backgroundImage: NetworkImage(
                      dream.user.avatarImage,
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
                onPressed: () {},
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
                dream.text[0],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.mood),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.mood_bad),
              onPressed: () {},
            )
          ],
        )
      ],
    ),
  );
}
