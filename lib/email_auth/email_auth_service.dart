
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorCode;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    print('inside signIn');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");
      return "Signed In";
    } on FirebaseAuthException catch (errorCode) {
      if (errorCode.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (errorCode.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  Future<String> signUp({String email, String password, String username}) async {
    print('inside signUp');
    print('$email $password $username');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if(_firebaseAuth.currentUser != null)
        await _firebaseAuth.currentUser.updateProfile(displayName: username);

      print("Signed Up");
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (errorCode) {
      print(errorCode);
      return errorCode;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('Logout Successful (inside)!');
  }

  String getMessageFromErrorCode(errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }

}
