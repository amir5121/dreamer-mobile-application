import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

abstract class QuestionnaireStepWidget extends StatefulWidget implements Seekable {
  final Dream dream;
  final Function goToNext;
  final bool isGoingForward;

  QuestionnaireStepWidget(
      {Key key,
      @required this.dream,
      @required this.goToNext,
      @required this.isGoingForward})
      : super(key: key);
}
