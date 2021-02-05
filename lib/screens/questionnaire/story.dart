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
  final DreamViewModel dreamViewModel = DreamViewModel();

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

  Future<bool> _onWillPop() async {
    if (_current == 0) {
      Navigator.of(context).pop(false);
      return true;
    }
    if (_journalLogger[_current].previous()) {
      setState(() {
        _current--;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastItem = _current == _journalLogger.length - 1;

    return ChangeNotifierProvider(
      create: (context) {
        return dreamViewModel;
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Dots(
              count: _journalLogger.length,
              selected: _current,
            ),
            elevation: 0,
            centerTitle: true,
            actions: [
              DreamConsumer<DreamViewModel>(
                builder: (context, journalViewModel, child) {
                  return FlatButton(
                    child: Text(isLastItem ? "Finish" : "Next"),
                    onPressed: journalViewModel.isLoading
                        ? null
                        : () {
                            if (_journalLogger[_current].next()) {
                              goToNext();
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
                            }
                          },
                  );
                },
              ),
            ],
          ),
          body: _journalLogger[_current],
        ),
      ),
    );
  }

  void goToNext() {
    if (_current < _journalLogger.length - 1) {
      setState(() {
        _current++;
      });
    }
  }
}
