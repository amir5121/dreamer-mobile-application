import 'package:flutter/material.dart';

class DreamerScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;

  const DreamerScaffold({Key key, this.body, this.bottomNavigationBar, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dreamer"),
        elevation: 0,
        centerTitle: true,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}

class DreamTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final controller;

  const DreamTextField(
      {Key key,
      @required this.label,
      this.obscureText,
      @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        )
      ],
    );
  }
}
