import 'package:dreamer/base_widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordReController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordReController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel auth = context.watch<AuthViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.isLoading == false &&
          auth.hasError == false &&
          auth.madeSuccessfulRequest) {
        auth.reset();
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 10),
            content: Text(
              "Sign up successful. You can login now.",
              style: TextStyle(
                color: Colors.lightGreen,
              ),
            ),
          ),
        );
      }
    });
    return DreamerScaffold(
      body: Container(
        padding: EdgeInsets.all(48.0),
        child: Column(
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
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DreamTextField(
                    label: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DreamTextField(
                    label: "Retype Password",
                    controller: passwordReController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: DreamConsumer<AuthViewModel>(
                      builder: (context, auth, child) => RaisedButton(
                        child: Text('Sign up'),
                        onPressed: auth.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState.validate()) {
                                  auth.signUpWithPassword(
                                    usernameController.text,
                                    passwordController.text,
                                    passwordReController.text,
                                  );
                                }
                              },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login instead?"),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Login",
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
