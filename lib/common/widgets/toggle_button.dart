import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool active;
  final String label;
  final Function onPressed;

  const ToggleButton(
      {Key key, @required this.active, @required this.label, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: active ? Constants.deepPurple[500] : Constants.accentColor[700],
      child: Text(label),
      onPressed: onPressed,
    );
  }
}
