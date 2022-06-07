import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final List<Map> items = [
    {"name": "Pin code", "action": (context) {}},
    {"name": "Notifications", "action": (context) {}},
    {"name": "Support", "action": (context) {}},
    {"name": "Privacy Policy", "action": (context) {}},
    {"name": "Rate This App", "action": (context) {}},
    {"name": "Change Password", "action": (context) {}},
    {
      "name": "Log out",
      "action": (context) {
        Provider.of<AuthViewModel>(context, listen: false)
            .logout()
            .then((AuthViewModel authViewModel) {
          if (authViewModel.hasLoggedOut) Phoenix.rebirth(context);
        });
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border(
                  bottom: BorderSide(color: Constants.accentColor),
                ),
              ),
              child: FlatButton(
                onPressed: () {
                  items[index]["action"](context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    items[index]["name"],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
