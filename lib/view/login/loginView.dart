import 'package:flutter/material.dart';

import 'components/loginForm.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.purple,
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: LoginForm(),
        )
      ],
    ));
  }
}
