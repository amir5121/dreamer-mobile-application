import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/feeling_slider.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:flutter/material.dart';

import 'questionnaire_step_widget.dart';

class QuestionnaireOverallFeelings extends QuestionnaireStepWidget {
  QuestionnaireOverallFeelings({dream, goToNext, isGoingForward})
      : super(dream: dream, goToNext: goToNext, isGoingForward: isGoingForward);

  final _QuestionnaireOverallFeelingState _questionnaireOverallFeelingState =
      _QuestionnaireOverallFeelingState();

  @override
  _QuestionnaireOverallFeelingState createState() {
    return _questionnaireOverallFeelingState;
  }

  @override
  bool next() {
    return _questionnaireOverallFeelingState.next();
  }

  @override
  bool previous() {
    return _questionnaireOverallFeelingState.previous();
  }
}

class _QuestionnaireOverallFeelingState
    extends State<QuestionnaireOverallFeelings> implements Seekable {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.0),
      child: Column(
        children: [
          Text(
            'What feelings did you experience in your dream?',
            style: Theme.of(context).textTheme.headline6,
          ),
          if (widget.dream.feelings != null)
            ...widget.dream.feelings!
                .map<Widget>(
                  (Feeling feeling) => Container(
                    margin: EdgeInsets.only(top: 8),
                    child: FeelingSlider(
                      label: feeling.feelingParent.capitalize(),
                      setValue: (int value) => feeling.rate = value,
                      initialValue: feeling.rate,
                    ),
                  ),
                )
                .toList(),
        ],
      ),
    );
  }

  @override
  bool next() {
    int sumOfFeeling = 0;
    widget.dream.feelings
        ?.forEach((Feeling element) => sumOfFeeling += element.rate);
    if (sumOfFeeling < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 6),
          content: Text("Please select feelings you had during sleep."),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  bool previous() {
    return true;
  }
}
