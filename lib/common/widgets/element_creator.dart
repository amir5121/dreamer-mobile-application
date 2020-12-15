import 'package:flutter/material.dart';

class ElementCreator extends StatefulWidget {
  final String label;
  final List<TextEditingController> controllers = [TextEditingController()];

  ElementCreator({Key key, @required this.label}) : super(key: key);

  @override
  _ElementCreatorState createState() => _ElementCreatorState();
}

class _ElementCreatorState extends State<ElementCreator> {
  FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 8),
        Wrap(
          children: [
            ...widget.controllers
                .asMap()
                .map<int, Widget>(
                  (int index, TextEditingController controller) => MapEntry(
                      index,
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          child: TextFormField(
                            controller: controller,
                            focusNode: widget.controllers.length - 1 == index && index > 0
                                ? focusNode
                                : null,
                          ),
                        ),
                      )),
                )
                .values
                .toList(),
            ButtonTheme(
              minWidth: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OutlineButton(
                  // padding: EdgeInsets.all(0),
                  child: Icon(Icons.add),
                  onPressed: () {
                    if (widget.controllers
                            .where((TextEditingController controller) =>
                                controller.text.length == 0)
                            .length <
                        1) {
                      setState(
                        () {
                          widget.controllers.add(
                            TextEditingController(),
                          );
                        },
                      );
                    }
                  },
                  shape: CircleBorder(
                    side: BorderSide(),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
