import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkPassword(User user, String password) async {
  if (user.email == null) {
    throw 'The user does not have email.';
  }

  try {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: password);
    if (userCredential.credential != null) {
      user.reauthenticateWithCredential(userCredential.credential!);
    }

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      rethrow;
    } else if (e.code == 'wrong-password') {
      return false;
    } else {
      rethrow;
    }
  }
}
