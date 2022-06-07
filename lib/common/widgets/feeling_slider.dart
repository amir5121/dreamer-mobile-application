import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';

class FeelingSlider extends StatefulWidget {
  final String label;
  final Function setValue;
  final int initialValue;

  const FeelingSlider(
      {required this.label, required this.setValue, required this.initialValue})
      : super();

  @override
  _FeelingSliderState createState() => _FeelingSliderState();
}

class _FeelingSliderState extends State<FeelingSlider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = widget.initialValue.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(widget.label),
        ),
        Expanded(
          child: Slider(
            value: _currentSliderValue,
            min: 0,
            max: Constants.maxFeelingSlider.toDouble(),
            divisions: Constants.maxFeelingSlider,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              widget.setValue(
                value.toInt(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text("${_currentSliderValue.toInt()}/10"),
        ),
      ],
    );
  }
}
