import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:flutter/material.dart';

abstract class QuestionnaireStepWidget extends StatefulWidget implements Forward {
  final Dream dream;

  QuestionnaireStepWidget({Key key, this.dream}) : super(key: key);
}
