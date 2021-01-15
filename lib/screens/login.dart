import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/common/widgets/dreamer_text_field.dart';
import 'package:dreamer/common/widgets/let_scroll.dart';
import 'package:dreamer/common/widgets/text_ful_divider.dart';
import 'package:dreamer/view_models/auth_view_model.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: LetScroll(
        child: Container(
          padding: EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 48,
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
                      child: DreamConsumer2<AuthViewModel, ConfigurationsViewModel>(
                        builder: (_, auth, configurationsViewModel, __) => RaisedButton(
                          child: Text('Log in'),
                          onPressed: auth.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState.validate()) {
                                    auth
                                        .loginWithPassword(
                                      usernameController.text,
                                      passwordController.text,
                                    )
                                        .then((AuthViewModel authViewModel) {
                                      if (auth.login?.accessToken != null) {
                                        configurationsViewModel
                                            .loadConfigurations(context);
                                        Navigator.pushReplacementNamed(context, '/home');
                                      }
                                    });
                                  }
                                },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextFulDivider(text: Text("OR")),
              SizedBox(height: 16),
              Text("Log in with"),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Colors.white70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.clean_hands),
                          Expanded(
                            child: Text(
                              "Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.wash),
                          Expanded(
                            child: Text(
                              "Facebook",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
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
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/sign-up');
                    },
                    child: Text(
                      "Sign up",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
