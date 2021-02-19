import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/widgets/dreamer_dialog.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool active;
  final String label;
  final String description;
  final Function onPressed;

  const ToggleButton(
      {Key key,
      @required this.active,
      @required this.label,
      @required this.onPressed,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: active ? Constants.deepPurple[500] : Constants.accentColor[700],
      child: description == null
          ? Text(label)
          : Stack(
              alignment: Alignment.center,
              children: [
                Text(label),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => showDreamDialog(
                            context,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 32,
                                bottom: 96,
                                left: 32,
                                right: 32,
                              ),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      label,
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(height: 8),
                                    Text(description,
                                        style: Theme.of(context).textTheme.headline6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      child: Icon(Icons.info)),
                )
              ],
            ),
      onPressed: onPressed,
    );
  }
}
