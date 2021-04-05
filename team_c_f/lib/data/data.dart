import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool _signIn = false;
  String _userId = '';

  bool get signIn => _signIn;
  String get userId => _userId;

  String getUserId() {
    return FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser.uid
        : '';
  }

  Future updateSignInfo() async {
    if (FirebaseAuth.instance.currentUser != null) {
      _userId = FirebaseAuth.instance.currentUser.uid;
      _signIn = await DatabaseService().userExists(userId: _userId);
    } else {
      _signIn = false;
    }
    
    notifyListeners();
  }
}
