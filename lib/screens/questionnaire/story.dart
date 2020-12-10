import 'package:dreamer/common/widgets/dots.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/feeling_detail.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_feeling_picker.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_overall_feelings.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_init.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  int _current = 0;
  final Dream dream = Dream();
  final List<QuestionnaireStepWidget> _journalLogger = [];

  @override
  void initState() {
    dream.feelings = context
        .read<ConfigurationsViewModel>()
        .configurations
        .data
        .mainFeelings
        .map((FeelingDetail e) => e.convertToFeeling())
        .toList();
    _journalLogger.add(QuestionnaireInit(dream: dream));
    _journalLogger.add(QuestionnaireOverallFeelings(dream: dream));
    _journalLogger.add(QuestionnaireFeelingPicker(dream: dream));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastItem = _current == _journalLogger.length - 1;
    return ChangeNotifierProvider(
      create: (context) => JournalViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Dots(
            count: _journalLogger.length,
            selected: _current,
          ),
          elevation: 0,
          centerTitle: true,
          actions: [
            FlatButton(
              child: Text(isLastItem ? "Finish" : "Next"),
              onPressed: () {
                if (_journalLogger[_current].next()) {
                  if (_current < _journalLogger.length - 1) {
                    setState(() {
                      _current++;
                    });
                  } else {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                }
              },
            )
          ],
        ),
        body: _journalLogger[_current],
      ),
    );
  }
}
