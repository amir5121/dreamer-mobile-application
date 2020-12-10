import 'package:dreamer/common/constants.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/models/dream/feeling_detail.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/common/extensions/string_extension.dart';

class QuestionnaireFeelingPicker extends QuestionnaireStepWidget {
  final _questionnaireFeelingPickerState = _QuestionnaireFeelingPickerState();

  QuestionnaireFeelingPicker({Key key, dream}) : super(key: key, dream: dream);

  @override
  _QuestionnaireFeelingPickerState createState() {
    return _questionnaireFeelingPickerState;
  }

  @override
  bool next() {
    return _questionnaireFeelingPickerState.next();
  }
}

class _QuestionnaireFeelingPickerState extends State<QuestionnaireFeelingPicker>
    implements Forward {
  int _current = 0;
  String pickedOutFeeling;

  @override
  Widget build(BuildContext context) {
    List<FeelingDetail> choices = context.select(
        (ConfigurationsViewModel configurationsViewModel) => configurationsViewModel
            .configurations.data.feelings
            .where((FeelingDetail element) =>
                widget.dream.feelings[_current].feelingParent == element.parentType)
            .toList());
    return Padding(
      padding: EdgeInsets.only(top: 36.0, left: 36.0, right: 36.0),
      child: Column(
        children: [
          Text(
            'In ${choices[1].parentType.capitalize()}, to which you were feeling closer?',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index < choices.length) {
                  FeelingDetail choice = choices[index];
                  return RaisedButton(
                    color: pickedOutFeeling == choice.detailedType
                        ? Constants.deepPurple[500]
                        : Constants.accentColor[700],
                    child: Text(choice.detailedType.split("_")[1].capitalize()),
                    onPressed: () {
                      setState(() {
                        pickedOutFeeling = choice.detailedType;
                      });
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
    widget.dream.feelings
        .singleWhere(
            (Feeling element) => pickedOutFeeling.split("_")[0] == element.feelingParent)
        .feeling = pickedOutFeeling;

    if (_current < widget.dream.feelings.length - 1) {
      setState(() {
        pickedOutFeeling = null;
        _current++;
      });
      return false;
    }
    return true;
  }
}
