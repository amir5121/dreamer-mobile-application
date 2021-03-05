import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dreamer_dialog.dart';

class DreamPostHeader extends StatelessWidget {
  final Dream dream;
  final Function onDeleteCallback;

  const DreamPostHeader({Key key, this.dream, this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // child: Text("Dreamer"),
                    radius: 24,
                    backgroundImage: NetworkImage(
                      dream.user.avatar,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dream.user.fullName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          dream.user.email,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => DreamDialog(
                      child: Column(
                        children: [
                          TextButton(
                            child: Text("Edit Dream"),
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              Navigator.pushNamed(
                                context,
                                '/story',
                                arguments: dream.identifier,
                              );
                            },
                          ),
                          TextButton(
                            child: Text("Delete Dream"),
                            onPressed: () {
                              DreamViewModel dreamViewModel =
                                  context.read<DreamViewModel>();
                              dreamViewModel
                                  .deleteDream(dream.identifier)
                                  .then((DreamViewModel value) {
                                if (!value.hasError) {
                                  // Navigator.pop(context);
                                  Navigator.pop(dialogContext);
                                  if (onDeleteCallback != null) onDeleteCallback();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 6),
                                      content: Text("Dream was removed."),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Text(
                dream.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                dream.createdFormatted,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
