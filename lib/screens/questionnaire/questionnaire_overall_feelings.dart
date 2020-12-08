import 'package:dreamer/common/forward_interface.dart';
import 'package:flutter/material.dart';

import 'questionnaire_step_widget.dart';

class QuestionnaireOverallFeelings extends QuestionnaireStepWidget {
  QuestionnaireOverallFeelings({Key key, dream}) : super(key: key, dream: dream);

  final _questionnaireOverallFeelingState = _QuestionnaireOverallFeelingState();

  @override
  _QuestionnaireOverallFeelingState createState() {
    return _questionnaireOverallFeelingState;
  }

  @override
  bool next() {
    return _questionnaireOverallFeelingState.next();
  }
}

class _QuestionnaireOverallFeelingState extends State<QuestionnaireOverallFeelings>
    implements Forward {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.0),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }

  @override
  bool next() {
    return true;
    // if (_formKey.currentState.validate()) {
    //   widget.dream.title = titleController.text;
    //   widget.dream.text = titleController.text;
    //   widget.dream.dreamDate = DateTime(
    //     selectedDate.year,
    //     selectedDate.month,
    //     selectedDate.day,
    //     selectedTime.hour,
    //     selectedTime.minute,
    //   );
    // }
  }
}
