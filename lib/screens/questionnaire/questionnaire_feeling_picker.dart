import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/toggle_button.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:dreamer/models/dream/feeling_detail.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionnaireFeelingPicker extends QuestionnaireStepWidget {
  final _QuestionnaireFeelingPickerState _questionnaireFeelingPickerState =
      _QuestionnaireFeelingPickerState();

  QuestionnaireFeelingPicker({dream, goToNext, isGoingForward})
      : super(dream: dream, goToNext: goToNext, isGoingForward: isGoingForward);

  @override
  _QuestionnaireFeelingPickerState createState() {
    return _questionnaireFeelingPickerState;
  }

  @override
  bool next() {
    return _questionnaireFeelingPickerState.next();
  }

  @override
  bool previous() {
    return _questionnaireFeelingPickerState.previous();
  }
}

class _QuestionnaireFeelingPickerState extends State<QuestionnaireFeelingPicker>
    implements Seekable {
  int _current = 0;
  String? pickedOutFeeling;

  @override
  void initState() {
    if (widget.isGoingForward) {
      _current = 0;
    } else {
      _current = widget.dream.feelings
              ?.where((Feeling feeling) => feeling.rate != 0)
              .toList()
              .length ??
          0 - 1;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FeelingDetail>? choices = context.select(
      (ConfigurationsViewModel configurationsViewModel) =>
          configurationsViewModel.configurations?.data.feelings
              .where((FeelingDetail element) =>
                  widget.dream.feelings
                      ?.where((Feeling feeling) => feeling.rate != 0)
                      .toList()[_current]
                      .feelingParent ==
                  element.parentType)
              .toList(),
    );
    return Padding(
      padding: EdgeInsets.only(top: 36.0, left: 36.0, right: 36.0),
      child: choices == null
          ? Text("N?A")
          : Column(
              children: [
                Text(
                  'In ${choices[1].parentType?.capitalize() ?? "N?A"}, to which you were feeling closer?',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: choices.length,
                    itemBuilder: (context, index) {
                      if (index < choices.length) {
                        FeelingDetail choice = choices[index];
                        pickedOutFeeling = widget.dream.feelings
                            ?.singleWhere((Feeling element) =>
                        choice.detailedType?.split("_")[0] ==
                                element.feelingParent)
                            .feeling;
                        return ToggleButton(
                          active: pickedOutFeeling == choice.detailedType,
                          label:
                              choice.detailedType?.split("_")[1].capitalize() ??
                                  "N?A",
                          description: choice.description,
                          onPressed: () {
                            setState(() {
                              pickedOutFeeling = choice.detailedType;
                            });
                            this.next();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
    );
  }

  @override
  bool next() {
    if (pickedOutFeeling != null)
      widget.dream.feelings
          ?.singleWhere((Feeling element) =>
              pickedOutFeeling?.split("_")[0] == element.feelingParent)
          .feeling = pickedOutFeeling!;

    if (_current <
        (widget.dream.feelings
                    ?.where((Feeling feeling) => feeling.rate != 0)
                    .toList()
                    .length ??
                0) -
            1) {
      setState(() {
        pickedOutFeeling = null;
        _current++;
      });
      return false;
    }
    widget.goToNext();
    return true;
  }

  @override
  bool previous() {
    if (_current > 0) {
      setState(() {
        _current--;
      });
      return false;
    }
    return true;
  }
}
