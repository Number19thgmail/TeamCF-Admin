import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User> signInWithGoogle() async {
  // Выполнение входа в Google-аккаунт
  final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
}

Future<bool> signOutGoogle({BuildContext? context}) async {
  // Выполнение выхода из Google-аккаунта
  FirebaseAuth.instance.signOut();
  return GoogleSignIn().signOut().then((value) => true);
}
