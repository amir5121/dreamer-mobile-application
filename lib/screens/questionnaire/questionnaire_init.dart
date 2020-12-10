import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/dreamer_fake_text_field.dart';
import 'package:dreamer/common/widgets/dreamer_text_field.dart';
import 'package:dreamer/common/widgets/let_scroll.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'questionnaire_step_widget.dart';

class QuestionnaireInit extends QuestionnaireStepWidget {
  QuestionnaireInit({Key key, dream}) : super(key: key, dream: dream);

  final _questionnaireInitState = _QuestionnaireInitState();

  @override
  _QuestionnaireInitState createState() {
    return _questionnaireInitState;
  }

  @override
  bool next() {
    return _questionnaireInitState.next();
  }
}

class _QuestionnaireInitState extends State<QuestionnaireInit> implements Forward {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime now = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 8),
      lastDate: DateTime(now.year, now.month, now.day + 1),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LetScroll(
      child: Container(
        padding: EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What did you dream?',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: DreamFakeTextField(
                    label: "Date",
                    value: DateFormat('yyyy-MM-dd').format(selectedDate),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: DreamFakeTextField(
                    label: "Time",
                    value: selectedTime.format(context),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DreamTextField(
                    label: "Title",
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DreamTextField(
                    label: "Description",
                    controller: descriptionController,
                    maxLines: 8,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool next() {
    if (_formKey.currentState.validate()) {
      widget.dream.title = titleController.text;
      widget.dream.text = titleController.text;
      widget.dream.dreamDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      return true;
    }
    return false;
  }
}
