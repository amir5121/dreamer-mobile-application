import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/widgets/dream_post_header.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

Widget dreamItem(Dream dream, context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        '/dream',
        arguments: dream.identifier,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(width: 1, color: Constants.accentColor),
        ),
      ),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          DreamPostHeader(dream: dream),
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
    ),
  );
}
