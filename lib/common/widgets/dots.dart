import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  final int count;
  final int selected;

  const Dots({required this.count, required this.selected}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected == index ? Constants.tertiaryColor : Constants.accentColor,
          ),
        ),
      ),
    );
  }
}
