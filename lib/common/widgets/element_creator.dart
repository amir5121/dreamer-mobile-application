import 'package:flutter/material.dart';

class ElementCreator extends StatefulWidget {
  final String label;
  final List<TextEditingController> controllers = [TextEditingController()];

  ElementCreator({Key key, @required this.label}) : super(key: key);

  @override
  _ElementCreatorState createState() => _ElementCreatorState();
}

class _ElementCreatorState extends State<ElementCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 8),
        Wrap(
          children: [
            ...widget.controllers
                .map<Widget>((TextEditingController controller) => Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.4,
                        child: TextFormField(
                          controller: controller,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ))
                .toList(),
            ButtonTheme(
              minWidth: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OutlineButton(
                  // padding: EdgeInsets.all(0),
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (widget.controllers
                              .where((TextEditingController controller) =>
                                  controller.text.length == 0)
                              .length <
                          1) {
                        widget.controllers.add(TextEditingController());
                      }
                    });
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
