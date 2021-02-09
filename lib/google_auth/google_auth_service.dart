import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleSignIn() async {
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

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}