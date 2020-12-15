import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dots.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/feeling_detail.dart';
import 'package:dreamer/screens/landing.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_clearance_picker.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_element.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_feeling_picker.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_init.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_overall_feelings.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
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
    _journalLogger.add(
      QuestionnaireInit(
        dream: dream,
        goToNext: goToNext,
      ),
    );
    _journalLogger.add(
      QuestionnaireClearancePicker(
        dream: dream,
        goToNext: goToNext,
      ),
    );
    _journalLogger.add(
      QuestionnaireOverallFeelings(
        dream: dream,
        goToNext: goToNext,
      ),
    );
    _journalLogger.add(
      QuestionnaireFeelingPicker(
        dream: dream,
        goToNext: goToNext,
      ),
    );
    _journalLogger.add(
      QuestionnaireElement(
        dream: dream,
        goToNext: goToNext,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DreamViewModel dreamViewModel = DreamViewModel();
    final bool isLastItem = _current == _journalLogger.length - 1;
    if (isLastItem) {
      dreamViewModel.submitDream(dream).then(
        (DreamViewModel journalResponse) {
          if (!journalResponse.hasError) {
            Navigator.pop(context);
            Navigator.popAndPushNamed(
              context,
              '/home',
              arguments: Landing.journal,
            );
          }
        },
      );
    }
    return ChangeNotifierProvider(
      create: (context) {
        return dreamViewModel;
      },
      child: DreamConsumer<DreamViewModel>(
        builder: (context, journalViewModel, child) {
          return Scaffold(
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
                  onPressed: journalViewModel.isLoading
                      ? null
                      : () {
                          if (_journalLogger[_current].next()) {
                            goToNext();
                          }
                        },
                ),
              ],
            ),
            body: _journalLogger[_current],
          );
        },
      ),
    );
  }

  void goToNext() {
    setState(() {
      if (_current < _journalLogger.length - 1) {
        _current++;
      }
    });
  }
}
