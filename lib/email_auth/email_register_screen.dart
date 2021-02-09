import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'email_auth_service.dart';
import 'email_login_screen.dart';

class EmailRegisteringScreen extends StatefulWidget {
  @override
  _EmailRegisteringScreenState createState() => _EmailRegisteringScreenState();
}

class _EmailRegisteringScreenState extends State<EmailRegisteringScreen> {
  TextEditingController _emailController, _usernameController;
  TextEditingController _passwordController, _rePasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _usernameController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _rePasswordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0),
                    Text(
                      'Email Register Demo',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Username" : null,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      validator: (email) {
                        RegExp regex = RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                        if (email.isEmpty)
                          return "Please Enter Email";
                        else if (!regex.hasMatch(email))
                          return "Please Enter a valid email address";
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Password" : null,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Password" : null,
                      controller: _rePasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re Enter Password',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      color: Colors.blueAccent,
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (_formKey.currentState.validate()) {
                          if (_usernameController.text != '' &&
                              _emailController.text != '' &&
                              _passwordController.text ==
                                  _rePasswordController.text) {
                            final provider = Provider.of<EmailAuthService>(
                                context,
                                listen: false);
                            provider.signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text,
                            );
                            // Timer(Duration(seconds: 5), () {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EmailLoginScreen(),
                              ),
                            );
                          }
                        } else if (_passwordController.text !=
                            _rePasswordController.text) {
                          final snackBar = SnackBar(
                              content:
                                  Text('Please type the password correctly.'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _passwordController.clear();
                          _rePasswordController.clear();
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    Divider(),
                    Text(
                      'Already have an account?? then',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Click to Login Page',
                        style: TextStyle(
                          fontSize: 20.0,
                          // color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        print('Login Pressed !!');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EmailLoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
