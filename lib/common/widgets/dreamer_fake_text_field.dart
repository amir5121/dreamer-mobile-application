import 'package:flutter/material.dart';

class DreamFakeTextField extends StatelessWidget {
  final String label;
  final String value;
  final Function onPressed;

  const DreamFakeTextField(
      {Key key, @required this.label, @required this.value, @required this.onPressed})
      : super(key: key);

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
