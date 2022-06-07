import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFulDivider extends StatelessWidget {
  final Widget text;
  final int startFlex;
  final int endFlex;

  const TextFulDivider(
      {required this.text, this.startFlex = 1, this.endFlex = 3})
      : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (startFlex > 0)
          Expanded(
            flex: startFlex,
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ),
        text,
        if (endFlex > 0)
          Expanded(
            flex: endFlex,
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          )
      ],
    );
  }
}
