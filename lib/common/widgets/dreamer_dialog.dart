import 'package:dreamer/common/constants.dart';
import 'package:flutter/material.dart';

void showDreamDialog(BuildContext context, {@required Widget child}) {
  showDialog(
    context: context,
    builder: (_) => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // A simplified version of dialog.
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 32,
                  left: 64,
                  right: 64,
                ),
                child: Container(
                  width: 64,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Constants.accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ],
    ),
  );
}
