import 'package:flutter/material.dart';

class DreamFakeTextField extends StatelessWidget {
  final String label;
  final String value;
  final Function() onPressed;

  const DreamFakeTextField(
      {required this.label, required this.value, required this.onPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 8,
        ),
        OutlineButton(
          padding: EdgeInsets.symmetric(vertical: 12),
          onPressed: onPressed,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );
  }
}
