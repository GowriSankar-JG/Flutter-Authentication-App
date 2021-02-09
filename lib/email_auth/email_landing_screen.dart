import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'email_auth_service.dart';

class EmailLandingPage extends StatefulWidget {
  static final routeName = '/emailLandingPage';

  @override
  _EmailLandingPageState createState() => _EmailLandingPageState();
}

class _EmailLandingPageState extends State<EmailLandingPage> {

  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${currentUser.displayName}',
              style: TextStyle(
                fontSize: 20.0,
              ),),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.teal[400],
                onPressed: () async {
                  final provider =
                  Provider.of<EmailAuthService>(context, listen: false);
                  provider.signOut();
                  print('Logout Successful !');
                  Navigator.pop(context);
                },
                child: Text('Logout',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
