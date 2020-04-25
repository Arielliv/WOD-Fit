import 'dart:convert';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseUser currentUser;
  String name;
  String email;
  String _imageUrl;

  String _token;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  String get imageUrl {
    return _imageUrl;
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      await saveUserCardentials(googleSignInAuthentication);

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return login(credential);
    } catch (error) {
      throw error;
    }
  }

  Future<void> saveUserCardentials(
      GoogleSignInAuthentication googleSignInAuthentication) async {
    final prefs = await SharedPreferences.getInstance();
    final userCardentials = json.encode(
      {
        'accessToken': googleSignInAuthentication.accessToken,
        'idToken': googleSignInAuthentication.idToken,
      },
    );
    prefs.setString('userCardentials', userCardentials);
  }

  Future<AuthCredential> getUserCardentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userCardentials')) {
      return null;
    } else {
      final extractedUserData = json.decode(prefs.getString('userCardentials'))
          as Map<String, Object>;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: extractedUserData['accessToken'],
        idToken: extractedUserData['userId'],
      );
      return credential;
    }
  }

  Future<String> login(AuthCredential credential) async {
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    name = user.displayName;
    email = user.email;
    _imageUrl = user.photoUrl;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    currentUser = await _auth.currentUser();

    currentUser.getIdToken().then((IdTokenResult) => {_token = IdTokenResult.token});
    _userId = currentUser.uid;
    assert(user.uid == currentUser.uid);
    notifyListeners();
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    _token = null;
    _userId = null;
    await googleSignIn.signOut();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userCardentials');
    prefs.clear();
    print("User Sign Out");
  }

  Future<String> tryAutoLogin() async {
    final AuthCredential credential = await getUserCardentials();
    return login(credential);
  }
}
