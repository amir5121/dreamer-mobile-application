import 'dart:math';

import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Waveform extends StatelessWidget {
  final List<double> _wave;
  final double _progress;
  static const int _MAX_HEIGHT = 50;

  const Waveform({required wave, required progress})
      : _wave = wave,
        _progress = progress,
        super();

  List<double> calculateCount(double maxWidth) {
    final int columnCount = maxWidth ~/ 5;
    // so the logic is fist find how many item should be removed or added
    // if itemCountToAddOrRemove is grater than 0 we should add itemCountToAddOrRemove items to the list
    // if itemCountToAddOrRemove is less than 0 we should take itemCountToAddOrRemove from the the list
    final int itemCountToAddOrRemove = _wave.length - columnCount;
    if (itemCountToAddOrRemove != 0) {
      final bool shouldAdd = itemCountToAddOrRemove < 0;
      final double step = (shouldAdd
              ? _wave.length / columnCount
              : _wave.length / itemCountToAddOrRemove.abs())
          .abs();
      //  step is the length of each step that we should add or take from the list

      for (int i = itemCountToAddOrRemove.abs(); i > 0; i--) {
        final int index = (i * step).toInt();
        if (shouldAdd) {
          _wave.insert(index, _wave[index]);
        } else {
          _wave.removeAt(index - 1);
        }
      }
    }
    return _wave
        .map((height) => max(min(_MAX_HEIGHT, height * height / 200), 1).toDouble())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Container(
              height: _MAX_HEIGHT.toDouble(),
            ),
            ...calculateCount(constraints.maxWidth)
                .asMap()
                .map<int, Widget>((int key, double height) => MapEntry(
                    key,
                    Container(
                      width: 4,
                      height: height,
                      color: _progress < (key / _wave.length)
                          ? Constants.accentColor
                          : Constants.tertiaryColor,
                      margin: EdgeInsets.only(left: 1),
                    )))
                .values
                .toList()
          ],
        );
      },
    );
  }
}
