import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dreamer_dialog.dart';
import 'package:dreamer/common/widgets/dreamer_fake_text_field.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/dreamer_text_field.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/configurations/configurations.dart';
import 'package:dreamer/models/user/gender.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'journal/profile_header.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  String selectedGender;

  DateTime selectedDate;
  DateTime now = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    genderController.dispose();
  }

  @override
  void initState() {
    User user = context.read<ConfigurationsViewModel>().configurations.data.self;
    nameController.text = user.fullName;
    selectedDate = user.birthDate;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day + 1),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext buildContext) {
    return DreamerScaffold(
      actions: [
        DreamConsumer<AuthViewModel>(
          builder: (context, auth, child) => FlatButton(
            child: Text('Save'),
            onPressed: auth.isLoading
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      auth
                          .updateSelf(
                        UpdateUser(
                          nameController.text,
                          selectedGender,
                          selectedDate,
                        ),
                      )
                          .then((_) {
                        buildContext.read<ConfigurationsViewModel>().loadConfigurations();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text(
                              "Updated profile!",
                              style: TextStyle(
                                color: Colors.lightGreen,
                              ),
                            ),
                          ),
                        );
                      });
                    }
                  },
          ),
        ),
      ],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: ProfileHeader(inProfileEdit: false),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return _editForm();
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _editForm() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 32.0,
        right: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DreamConsumer<ConfigurationsViewModel>(
            builder: (context, configurations, child) {
              User user = configurations.configurations.data.self;
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    DreamTextField(
                      label: "Name",
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DreamFakeTextField(
                      label: "Birth date",
                      value: selectedDate == null
                          ? ""
                          : DateFormat('yyyy-MM-dd').format(selectedDate),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    genderBox(user, context, configurations.configurations.data),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Column genderBox(User user, context, Configurations configurations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: selectedGender != null
                ? Text(
                    configurations.genderChoices
                        .singleWhere((Gender gender) => gender.value == selectedGender)
                        .label,
                  )
                : user.gender != null
                    ? Text(user.genderDisplay)
                    : null,
            onPressed: () {
              showDreamDialog(
                context,
                child: Column(
                  children: [
                    ...configurations.genderChoices
                        .map<Widget>(
                          (Gender gender) => FlatButton(
                            child: Text(gender.label),
                            onPressed: () {
                              setState(() {
                                this.selectedGender = gender.value;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList()
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
