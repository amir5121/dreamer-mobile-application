import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/element_creator.dart';
import 'package:dreamer/common/widgets/let_scroll.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_element.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionnaireElement extends QuestionnaireStepWidget {
  static const placeIndex = 0;
  static const characterIndex = 1;
  static const objectIndex = 2;
  final _QuestionnaireElementState questionnaireElementState =
      _QuestionnaireElementState();

  final List<ElementCreator> elementCreators = [];

  QuestionnaireElement({Key key, Dream dream, Function goToNext, bool isGoingForward})
      : super(
            key: key, dream: dream, goToNext: goToNext, isGoingForward: isGoingForward) {
    elementCreators.add(ElementCreator(
      label: "Character",
      element: dream.elements?.firstWhere(
        (DreamElement element) => element.type == Constants.ELEMENT_CHARACTER,
        orElse: () => null,
      ),
    ));
    elementCreators.add(ElementCreator(
      label: "Place",
      element: dream.elements?.firstWhere(
        (DreamElement element) => element.type == Constants.ELEMENT_PLACE,
        orElse: () => null,
      ),
    ));
    elementCreators.add(ElementCreator(
      label: "Object",
      element: dream.elements?.firstWhere(
        (DreamElement element) => element.type == Constants.ELEMENT_OBJECT,
        orElse: () => null,
      ),
    ));
  }

  @override
  _QuestionnaireElementState createState() {
    return questionnaireElementState;
  }

  @override
  bool next() {
    return questionnaireElementState.next();
  }

  @override
  bool previous() {
    return questionnaireElementState.previous();
  }
}

class _QuestionnaireElementState extends State<QuestionnaireElement> implements Seekable {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 36.0, left: 36.0, right: 36.0),
      child: LetScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What key elements where in your dream?',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.elementCreators[QuestionnaireElement.placeIndex],
                SizedBox(height: 16),
                widget.elementCreators[QuestionnaireElement.characterIndex],
                SizedBox(height: 16),
                widget.elementCreators[QuestionnaireElement.objectIndex],
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  bool next() {
    List<DreamElement> elements = [];
    widget.elementCreators.asMap().forEach(
          (int key, ElementCreator elementCreator) {
        String type = _getTypeByIndex(key);
        final elementTexts = elementCreator.controllers
            .where((TextEditingController controller) => controller.text.length > 0)
            .map<String>(
              (TextEditingController controller) => controller.text,
            )
            .toList();
        if (elementTexts.isNotEmpty) {
          elements.add(
            DreamElement(
              type: type,
              elements: elementTexts,
            ),
          );
        }
      },
    );
    if (elements.isNotEmpty) {
      widget.dream.elements = elements;
      return true;
    }

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            "Tags are empty. please set some tags so we could give you a better feedback."),
      ),
    );
    return false;
  }

  String _getTypeByIndex(int key) {
    switch (key) {
      case QuestionnaireElement.placeIndex:
        return Constants.ELEMENT_PLACE;
      case QuestionnaireElement.objectIndex:
        return Constants.ELEMENT_OBJECT;
      case QuestionnaireElement.characterIndex:
        return Constants.ELEMENT_CHARACTER;
    }
    throw Error();
  }

  @override
  bool previous() {
    return true;
  }
}
