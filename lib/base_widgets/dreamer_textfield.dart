import 'package:flutter/material.dart';

class DreamerScaffold extends StatelessWidget {
  final Widget body;

  const DreamerScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dreamer"),
          elevation: 0,
          centerTitle: true,
        ),
        body: body);
  }
}

class DreamTextField extends StatelessWidget {
  final String label;
  final bool obscureText;

  const DreamTextField({Key key, this.label, this.obscureText})
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
