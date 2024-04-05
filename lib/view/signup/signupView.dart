import 'package:flutter/material.dart';

import 'components/signupForm.dart';
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
              child: SignupForm(),
            )
          ],
        ));
  }
}

