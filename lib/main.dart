import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'email_auth/email_auth_service.dart';
import 'phone_auth/phone_login_screen.dart';
import 'email_auth/email_register_screen.dart';
import 'google_auth/google_auth_service.dart';
import 'google_auth/google_login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => EmailAuthService()),
        Provider(create: (_) => GoogleAuthService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Firebase App',
        home: SignInScreen(), //HomePage(),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Firebase App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hey Wanna\nAuthenticate?',
                style: TextStyle(
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                width: 180.0,
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  color: Colors.redAccent,
                  child: Text(
                    'SignIn with Google',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  onPressed: () {
                    print('SignIn with Google Clicked !!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleLoginPage()));
                  },
                ),
              ),
              Container(
                width: 180.0,
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  color: Colors.blueAccent,
                  child: Text(
                    'SignIn with Email',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print('SignIn with Email Clicked !!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EmailRegisteringScreen()));
                  },
                ),
              ),
              Container(
                width: 180.0,
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  color: Colors.lightGreenAccent,
                  child: Text(
                    'SignIn with Phone',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print('SignIn with Phone Clicked !!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PhoneLoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
