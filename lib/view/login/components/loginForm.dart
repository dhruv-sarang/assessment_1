import 'package:e_learning_app/preference/pref_manager.dart';
import 'package:e_learning_app/view/homeScreen.dart';
import 'package:flutter/material.dart';

import '../../signup/signupView.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _eMailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void initState() {
    loadData();
    super.initState();
    print('Login : ${PrefManager.getLoginStatus()}');
  }

  String eMail = '', password = '';

  void loadData() {
    setState(() {
      PrefManager.getEmail(eMail);
      PrefManager.getPassword(password);
    });
  }

  void status(st, BuildContext context) {
    st=!st;
    PrefManager.statusChange(st);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Transform.rotate(
            angle: -35 * 3.1415926535897932 / 180,
            child: Text('E',
                style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'ECORP',
          style: TextStyle(color: Colors.orange, fontSize: 45),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _eMailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          prefixIcon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.grey.shade700,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isHidden ? true : false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey.shade700,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _toggleVisibility();
                          },
                          icon: _isHidden
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot Passwor?',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                  Container(
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        status(PrefManager.getLoginStatus(), context);
                        String emailController = _eMailController.text.trim();
                        String passwordController = _passwordController.text.trim();
                        if (PrefManager.getEmail(eMail) == emailController &&
                            PrefManager.getPassword(password) == passwordController) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          ); //true
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('E-Mail or Password incorrect'),
                            ),
                          );
                          // Fluttertoast.showToast(msg: 'E-Mail or Password incorrect');
                          //false
                        }
                      },
                      child: Text('LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupView(),
                          ),
                          (route) => false);
                    },
                    child: Text('SIGNUP',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
