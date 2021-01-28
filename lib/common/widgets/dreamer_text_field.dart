import 'package:flutter/material.dart';

class DreamTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final bool shouldValidate;
  final TextEditingController controller;
  final int maxLines;

  const DreamTextField(
      {Key key,
      @required this.label,
      this.obscureText,
      @required this.controller,
      this.maxLines = 1,
      this.shouldValidate = true})
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
          maxLines: maxLines,
          validator: (value) {
            if (value.isEmpty && this.shouldValidate) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        )
      ],
    );
  }
}
