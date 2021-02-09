import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'email_auth_service.dart';
import 'email_landing_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email Login Demo',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _emailController,
                  validator: (email){
                    RegExp regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                    if (email.isEmpty) return "Please Enter Email";
                    else if (!regex.hasMatch(email)) return "Please Enter a valid email address";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) => (value.isEmpty) ? "Please Enter Password" : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      color: Colors.blueAccent,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        // try {
                        //   User user = (await FirebaseAuth.instance
                        //       .signInWithEmailAndPassword(
                        //     email: _emailController.text,
                        //     password: _passwordController.text,)).user;
                        //   print(user.displayName);
                        //   if(user != null){
                        //     Navigator.push(context, MaterialPageRoute(
                        //         builder: (BuildContext context) {
                        //           return EmailLandingPage();
                        //         }
                        //     ));
                        //   }
                        // } catch (e) {
                        //   print(e);
                        //   _passwordController.clear(); _emailController.clear();
                        //   print('fucked up');
                        // }

                        if(_formKey.currentState.validate()){
                          final provider =
                          Provider.of<EmailAuthService>(context, listen: false);
                          provider.signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => EmailLandingPage(),
                              ));
                        }
                        _emailController.clear();
                        _passwordController.clear();
                      },
                    ),
                    RaisedButton(
                      color: Colors.orange,
                      child: Text(
                        'Return to Home',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context)=>SignInScreen())),
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
}
