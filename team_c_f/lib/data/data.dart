import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_c_f/servise/auth.dart';
import 'package:team_c_f/servise/operationdb.dart';

import 'shortmatch.dart';

class DataShortMatch with ChangeNotifier {
  List<ShortMatch> _data = [];
  DataShortMatch();
  List<ShortMatch> get getData => _data;

  void addData(List<ShortMatch> d) {
    _data = [..._data, ...d];

    notifyListeners();
  }

  void clearData() {
    _data = [];
  }

  void selectMatch({ShortMatch m, bool select}) {
    _data.where((element) => element == m).first.selected = select;
    notifyListeners();
  }

  int get countSelected => _data.where((element) => element.selected).length;
}

class Account with ChangeNotifier {
  bool _signInGoogle = false;
  bool _registedInApp = false;
  String _userId = '';

  bool get signIn => _signInGoogle;
  bool get registedInApp => _registedInApp;
  String get userId => _userId;

  Future initInfo() async {
    if (FirebaseAuth.instance.currentUser != null) {
      _userId = FirebaseAuth.instance.currentUser.uid;
      _signInGoogle = true;
      _registedInApp = await DatabaseService().userExists(userId: _userId);
    } else {
      _userId = '';
      _signInGoogle = false;
      _registedInApp = false;
    }
    notifyListeners();
  }

  Future changeSignIn() async {
    _signInGoogle ? await signOutGoogle() : await signInWithGoogle();
    initInfo();
  }

  void registedUser(){
    _registedInApp = true;
    notifyListeners();
  }
}
