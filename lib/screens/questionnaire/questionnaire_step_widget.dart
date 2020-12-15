import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

abstract class QuestionnaireStepWidget extends StatefulWidget implements Forward {
  final Dream dream;
  final Function goToNext;

  QuestionnaireStepWidget({Key key, @required this.dream, @required this.goToNext})
      : super(key: key);
}
