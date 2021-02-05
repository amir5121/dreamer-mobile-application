import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/toggle_button.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_clearance.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionnaireClearancePicker extends QuestionnaireStepWidget {
  _QuestionnaireClearancePickerState _questionnaireClearancePickerState =
      _QuestionnaireClearancePickerState();

  QuestionnaireClearancePicker({Key key, dream, goToNext})
      : super(key: key, dream: dream, goToNext: goToNext);

  @override
  _QuestionnaireClearancePickerState createState() {
    return _questionnaireClearancePickerState = _QuestionnaireClearancePickerState();
  }

  @override
  bool next() {
    return _questionnaireClearancePickerState.next();
  }

  @override
  bool previous() {
    return _questionnaireClearancePickerState.previous();
  }
}

class _QuestionnaireClearancePickerState extends State<QuestionnaireClearancePicker>
    implements Seekable {
  int pickedOutFeeling;
  Dream widgetDream;

  @override
  void initState() {
    widgetDream = widget.dream;
    pickedOutFeeling = widgetDream.dreamClearance;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DreamClearance> choices = context.select(
        (ConfigurationsViewModel configurationsViewModel) =>
            configurationsViewModel.configurations.data.clearanceChoices.toList());
    return Padding(
      padding: EdgeInsets.only(top: 36.0, left: 36.0, right: 36.0),
      child: Column(
        children: [
          Text(
            'How clear was your dream?',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index < choices.length) {
                  DreamClearance choice = choices[index];
                  return ToggleButton(
                    active: pickedOutFeeling == choice.value,
                    label: choice.label.capitalize(),
                    onPressed: () {
                      setState(() {
                        pickedOutFeeling = choice.value;
                      });
                      this.next();
                    },
                  );
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  bool next() {
    if (pickedOutFeeling == null) {
      return false;
    }
    widget.dream.dreamClearance = pickedOutFeeling;
    widget.goToNext();
    return true;
  }

  @override
  bool previous() {
    return true;
  }
}
