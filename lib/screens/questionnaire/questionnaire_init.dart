import 'package:dreamer/common/forward_interface.dart';
import 'package:dreamer/common/widgets/dreamer_fake_text_field.dart';
import 'package:dreamer/common/widgets/dreamer_text_field.dart';
import 'package:dreamer/common/widgets/let_scroll.dart';
import 'package:dreamer/common/widgets/recorder.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/screens/questionnaire/questionnaire_step_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuestionnaireInit extends QuestionnaireStepWidget {
  final _QuestionnaireInitState _questionnaireInitState =
      _QuestionnaireInitState();

  QuestionnaireInit(
      {super.key,
      required super.dream,
      required super.goToNext,
      required super.isGoingForward});

  @override
  _QuestionnaireInitState createState() {
    return _questionnaireInitState;
  }

  @override
  bool next() {
    return _questionnaireInitState.next();
  }

  @override
  bool previous() {
    return _questionnaireInitState.previous();
  }
}

class _QuestionnaireInitState extends State<QuestionnaireInit>
    implements Seekable {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime now = DateTime.now();
  Dream? widgetDream;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
    final TimeOfDay? picked = await showTimePicker(
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
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widgetDream = widget.dream;
    if (widgetDream != null) {
      titleController.text = widgetDream?.title ?? "";
      descriptionController.text = widgetDream?.text ?? "";
      if (widgetDream?.dreamDate != null)
        selectedTime = TimeOfDay(
          hour: widgetDream!.dreamDate!.hour,
          minute: widgetDream!.dreamDate!.minute,
        );
      if (widgetDream?.dreamDate != null)
        selectedDate = widgetDream!.dreamDate!;
    }
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
                    shouldValidate: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text("Voice"),
                  ),
                  Recorder(
                    previousRecording: widgetDream?.voice,
                    setRecordingDirectory: (String directory, List<double> wave,
                        double recordingLength) {
                      widgetDream?.voice = directory;
                      widgetDream?.voiceWave = wave;
                      widgetDream?.voiceDuration = recordingLength;
                    },
                    recordingLengthInMilliSeconds: widgetDream?.voiceDuration,
                    recordingWave: widgetDream?.voiceWave,
                  )
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
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      widgetDream
        ?..title = titleController.text
        ..text = descriptionController.text
        ..dreamDate = DateTime(
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

  @override
  bool previous() {
    return true;
  }
}
