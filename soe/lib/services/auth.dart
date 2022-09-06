import 'package:firebase_auth/firebase_auth.dart';
import 'package:soe/models/currentUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create current user object
  CurrentUser _userFromFirebaseUser(User user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  //auth change user srteam
  Stream<CurrentUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
