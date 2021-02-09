import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'google_auth_service.dart';

class GoogleLandingPage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Next Screen',
              style: TextStyle(fontSize:20.0,color: Colors.white),
            ),
            Text(
              'Logged In',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(currentUser.photoURL),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ' + currentUser.displayName,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ' + currentUser.email,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<GoogleAuthService>(context,listen:false);
                provider.handleSignOut();
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}