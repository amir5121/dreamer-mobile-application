import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dreamer_dialog.dart';
import 'package:dreamer/common/widgets/dreamer_fake_text_field.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/dreamer_text_field.dart';
import 'package:dreamer/models/auth/update_user.dart';
import 'package:dreamer/models/configurations/configurations.dart';
import 'package:dreamer/models/user/gender.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:dreamer/screens/journal/profile_header.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
  String imagePath;

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
    User user = context.read<ConfigurationsViewModel>().authenticatedUser;
    nameController.text = user.fullName;
    selectedDate = user.birthDate;
    super.initState();
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (await Permission.storage.request().isGranted) {
      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      } else {
        print('No image selected.');
      }
    } else if (await Permission.storage.isPermanentlyDenied) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 6),
          action: SnackBarAction(
            label: 'Open settings',
            onPressed: () {
              openAppSettings();
            },
          ),
          content: Text(
            "Permission has been permanently denied. Grant permission from settings",
          ),
        ),
      );
    } else {
      // await Permission.microphone.request().then((value) => _recordAudio());
    }
    return null;
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
        DreamConsumer2<AuthViewModel, ConfigurationsViewModel>(
          builder: (context, auth, configurations, child) => FlatButton(
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
                          configurations.authenticatedUser.avatar,
                        ),
                      )
                          .then((_) {
                        configurations.loadConfigurations(context);
                        Scaffold.of(context).showSnackBar(
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
            delegate: ProfileHeader(inProfileEdit: true, pickImage: pickImage),
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
              if (imagePath != null) {
                configurations.authenticatedUser.avatar = imagePath;
                imagePath = null;
              }
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
                    genderBox(context, configurations.configurations.data),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Column genderBox(BuildContext context, Configurations configurations) {
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
                : configurations.self.gender != null
                    ? Text(configurations.self.genderDisplay)
                    : null,
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => DreamDialog(
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
