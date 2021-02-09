import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginPage extends StatefulWidget {
  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount _currentUser;
  String _contactText;
  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        print(_currentUser.displayName);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(_currentUser.photoUrl),
            radius: 50.0,
          ),
          Text(_currentUser.displayName ?? '',style: TextStyle(fontSize: 20.0),),
          Text(_currentUser.email ?? '',style: TextStyle(fontSize: 16.0),),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
