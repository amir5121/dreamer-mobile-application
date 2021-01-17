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

  void __successfulLogin(
    AuthViewModel auth,
    ConfigurationsViewModel configurationsViewModel,
  ) {
    if (auth.login?.accessToken != null) {
      configurationsViewModel.loadConfigurations(context);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DreamerScaffold(
      body: LetScroll(
        child: Container(
          padding: EdgeInsets.all(48.0),
          child: DreamConsumer2<AuthViewModel, ConfigurationsViewModel>(
            builder: (_, auth, configurationsViewModel, __) => Column(
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
                _loginForm(auth, configurationsViewModel),
                SizedBox(height: 32),
                TextFulDivider(text: Text("OR")),
                SizedBox(height: 16),
                Text("Log in with"),
                SizedBox(height: 8),
                _socialSignIn(auth, configurationsViewModel),
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
      ),
    );
  }

  Row _socialSignIn(AuthViewModel auth, configurationsViewModel) {
    return Row(
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
            onPressed: auth.isLoading
                ? null
                : () {
                    auth.signInWithGoogle().then(
                          (AuthViewModel auth) => __successfulLogin(
                            auth,
                            configurationsViewModel,
                          ),
                        );
                  },
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
    );
  }

  Form _loginForm(AuthViewModel auth, ConfigurationsViewModel configurationsViewModel) {
    return Form(
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
            child: RaisedButton(
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
                            .then(
                              (AuthViewModel auth) => __successfulLogin(
                                auth,
                                configurationsViewModel,
                              ),
                            );
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
