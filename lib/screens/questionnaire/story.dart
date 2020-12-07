import 'package:dreamer/base_widgets/dreamer_fake_text_field.dart';
import 'package:dreamer/base_widgets/dreamer_scaffold.dart';
import 'package:dreamer/base_widgets/dreamer_text_field.dart';
import 'package:dreamer/base_widgets/let_scroll.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
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
    // AuthViewModel auth = context.watch<AuthViewModel>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (auth.isLoading == false &&
    //       auth.hasError == false &&
    //       auth.madeSuccessfulRequest) {
    //     auth.reset();
    //     Navigator.pushReplacementNamed(context, '/login');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         duration: Duration(seconds: 10),
    //         content: Text(
    //           "Sign up successful. You can login now.",
    //           style: TextStyle(
    //             color: Colors.lightGreen,
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // });
    return DreamerScaffold(
      body: Container(
        padding: EdgeInsets.all(36.0),
        child: LetScroll(
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
                    // Container(
                    //   width: double.infinity,
                    //   child: DreamConsumer<AuthViewModel>(
                    //     builder: (context, auth, child) => RaisedButton(
                    //       child: Text('Sign up'),
                    //       onPressed: auth.isLoading
                    //           ? null
                    //           : () {
                    //               if (_formKey.currentState.validate()) {
                    //                 auth.signUpWithPassword(
                    //                   titleController.text,
                    //                   descriptionController.text,
                    //                 );
                    //               }
                    //             },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
