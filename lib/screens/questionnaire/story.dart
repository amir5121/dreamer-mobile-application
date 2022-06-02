import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dots.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/feeling.dart';
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
  final Object? identifier;

  const Story({this.identifier}) : super();

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  int _current = 0;
  bool _goingForward = true;
  Dream? dream;
  QuestionnaireStepWidget? _currentStep;
  final DreamViewModel dreamViewModel = DreamViewModel();
  final List<Function> _loggers = [
    (dream, goToNext, isGoingForward) => QuestionnaireInit(
          dream: dream,
          goToNext: goToNext,
          isGoingForward: isGoingForward,
        ),
    (dream, goToNext, isGoingForward) => QuestionnaireClearancePicker(
          dream: dream,
          goToNext: goToNext,
          isGoingForward: isGoingForward,
        ),
    (dream, goToNext, isGoingForward) => QuestionnaireOverallFeelings(
          dream: dream,
          goToNext: goToNext,
          isGoingForward: isGoingForward,
        ),
    (dream, goToNext, isGoingForward) => QuestionnaireFeelingPicker(
          dream: dream,
          goToNext: goToNext,
          isGoingForward: isGoingForward,
        ),
    (dream, goToNext, isGoingForward) => QuestionnaireElement(
          dream: dream,
          goToNext: goToNext,
          isGoingForward: isGoingForward,
        ),
  ];

  Future<bool> _onWillPop() async {
    if (_current == 0) {
      Navigator.of(context).pop(false);
      return true;
    }
    if (_currentStep != null && _currentStep!.previous()) {
      setState(() {
        _goingForward = false;
        _current--;
      });
    }
    return false;
  }

  void _setFeeling() {
    if (dream != null)
      dream?.feelings = context
          .read<ConfigurationsViewModel>()
          .configurations
          ?.data
          .mainFeelings
          .map((FeelingDetail e) {
        Feeling? previousFeeling;
        if (dream?.feelings != null)
          previousFeeling = dream?.feelings!.singleWhere(
            (Feeling feeling) {
              return feeling.feelingParent == e.parentType;
            },
            // orElse: () => null,
          );
        return Feeling(
          rate: previousFeeling?.rate ?? 0,
          feeling: previousFeeling?.feeling ?? "N?A",
          feelingParent: e.parentType,
        );
      }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastItem = _current == _loggers.length - 1;
    if (dream != null)
      _currentStep = _loggers[_current](dream, goToNext, _goingForward);
    return ChangeNotifierProvider(
      create: (context) {
        if (widget.identifier != null) {
          dreamViewModel
              .loadDream(widget.identifier! as String)
              .then((DreamViewModel value) {
            setState(() {
              dream = value.dream?.data;
              _setFeeling();
            });
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            setState(() {
              dream = null;
            });
            _setFeeling();
          });
        }
        return dreamViewModel;
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Dots(
              count: _loggers.length,
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
                      if (_currentStep != null && _currentStep!.next()) {
                              goToNext();
                              if (isLastItem && dream != null) {
                                dreamViewModel.submitDream(dream!).then(
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
          body: _currentStep != null ? _currentStep : Text("Loading"),
        ),
      ),
    );
  }

  void goToNext() {
    if (_current < _loggers.length - 1) {
      setState(() {
        _goingForward = true;
        _current++;
      });
    }
  }
}
