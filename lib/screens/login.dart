import 'package:dreamer/widgets/dreamer_scaffold.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign up',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DreamTextField(
                    label: "Username",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DreamTextField(
                    label: "Password",
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      textColor: Colors.grey,
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Log in'),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Buying not supported yet.'),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/catalog');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    "OR",
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                )
              ],
            ),
            Text("Log in with"),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Colors.white70,
                    child: Text(
                      "Google",
                      style: TextStyle(color: Colors.black54),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Facebook",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
