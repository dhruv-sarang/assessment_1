import 'package:e_learning_app/preference/pref_manager.dart';
import 'package:e_learning_app/utils/app_utils.dart';
import 'package:e_learning_app/view/login/loginView.dart';
import 'package:e_learning_app/view/homeScreen.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();

  bool _isHidden = true, _isHiddenConf = true, _isHiddenConfW = false;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleVisibilityConf() {
    setState(() {
      _isHiddenConf = !_isHiddenConf;
    });
  }

  String? _emailError, _passwordError;

  void registerAccount(
      String name, String email, String password, BuildContext context) {
    PrefManager.createAccount(name, email, password).then(
      (value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error occurred while creating account'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.20,
          child: Transform.rotate(
            angle: -35 * 3.1415926535897932 / 180,
            child: Text('E',
                style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
        ),
        Text(
          'ECORP',
          style: TextStyle(color: Colors.orange, fontSize: 45),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.60,
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
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _fNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _lNameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'E-Mail',
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        errorText: _emailError,
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
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
                        errorText: _passwordError,
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
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
                  Container(
                    height: 60,
                    child: TextField(
                      onChanged: (value) {
                        String ppp = _passwordController.text;
                        String ccc = _confPasswordController.text;

                        if (ppp == ccc) {
                          setState(() {
                            _isHiddenConfW = true;
                          });
                        } else {
                          setState(() {
                            _isHiddenConfW = false;
                          });
                        }
                      },
                      controller: _confPasswordController,
                      obscureText: _isHiddenConf ? true : false,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey.shade700),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        /*suffixIcon: IconButton(
                          onPressed: () {
                            _toggleVisibilityConf();
                          },
                          icon: _isHiddenConf
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),*/
                        suffixIcon: Icon(
                          _isHiddenConfW ? Icons.check_circle : null,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        String fName = _fNameController.text.trim();
                        String lName = _lNameController.text.trim();

                        String name =
                            '${_fNameController.text.trim()} ${_lNameController.text.trim()}';
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        String confPassword =
                            _confPasswordController.text.trim();

                        String? emailError = AppUtil.isValidEmail(email);
                        String? passwordError =
                            AppUtil.isValidPassword(password);

                        if (fName.isEmpty ||
                            lName.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Field is Empty'),
                            ),
                          );
                        } else if (emailError != null) {
                          // invalid email
                          setState(() {
                            _emailError = emailError;
                          });
                        } else if (passwordError != null) {
                          setState(() {
                            _passwordError = passwordError;
                          });
                        } else if (password == confPassword) {
                          print('$name, $email, $password');
                          registerAccount(name, email, password, context);

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pasword must be same'),
                            ),
                          );
                          // Fluttertoast.showToast(msg: 'Pasword must be same');
                          print('Pasword must be same');
                        }
                      },
                      child: Text('SIGNUP',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account?',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                              (route) => false);
                        },
                        child: Text('Login Here',
                            style:
                                TextStyle(fontSize: 14, color: Colors.indigo)),
                      ),
                    ],
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
