import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_c_f/data/data.dart';
import 'package:provider/provider.dart';

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
}

Future<bool> signOutGoogle({BuildContext context}) async {
  FirebaseAuth.instance.signOut();
  return GoogleSignIn().signOut().then((value) => true);
  //await signInWithGoogle();
}
