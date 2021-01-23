import 'package:dreamer/common/widgets/waveform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WaveformSlider extends StatelessWidget {
  final List<double> _wave;
  final double _progress;
  final Function tapCallback;

  const WaveformSlider(
      {Key key, @required wave, @required progress, @required this.tapCallback})
      : _wave = wave,
        _progress = progress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double widgetLength;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        print(
            "dragggg ${details.localPosition}, ${details.delta}, ${details.globalPosition}, ${details.primaryDelta}");
      },
      // onPanUpdate: (DragUpdateDetails details) {
      //   print(
      //       "paaannn ${details.localPosition}, ${details.delta}, ${details.globalPosition}, ${details.primaryDelta}");
      // },
      onTapUp: (TapUpDetails details) {
        tapCallback(details.localPosition.distance / widgetLength);
        print(
            "tapuppp ${details.localPosition}, ${details.globalPosition}, $widgetLength ${details.localPosition.distance / widgetLength}");
      },
      child: LayoutBuilder(builder: (context, constraints) {
        widgetLength = constraints.maxWidth;
        return Container(
          color: Colors.transparent,
          child: Waveform(wave: _wave, progress: _progress),
        );
      }),
    );
  }
}
