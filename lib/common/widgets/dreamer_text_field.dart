import 'package:flutter/material.dart';

class DreamTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final bool shouldValidate;
  final TextEditingController controller;
  final int maxLines;

  const DreamTextField(
      {required this.label,
      this.obscureText = false,
      required this.controller,
      this.maxLines = 1,
      this.shouldValidate = true})
      : super();

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
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLines,
          validator: (value) {
            if (value != null && value.isEmpty && this.shouldValidate) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        )
      ],
    );
  }
}
