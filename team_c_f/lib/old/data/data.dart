import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_c_f/old/servise/auth.dart';
import 'package:team_c_f/old/servise/operationdb.dart';

class Account with ChangeNotifier {
  // Единый класс с информацией о Google-аккаунте и регистрации в приложении
  bool? _signInGoogle = false;
  bool? _registedInApp = false;
  String? _userId = '';

  bool get signIn => _signInGoogle!; // Выполнен вход в Google-аккаунт
  bool get registedInApp =>
      _registedInApp!; // Выполнена ли регистрации в приложении
  String get userId => _userId!; // Уникальный идентификатор Google-аккаунта

  Account() {
    // Конструктор
    calculateVariables();
  }

  void calculateVariables() {
    // Вычисление переменных
    if (FirebaseAuth.instance.currentUser != null) {
      _userId = FirebaseAuth.instance.currentUser!.uid;
      _signInGoogle = true;
      DatabaseService().userExists(userId: _userId!).then((value) {
        _registedInApp = value;
        notifyListeners();
      });
    } else {
      _userId = '';
      _signInGoogle = false;
      _registedInApp = false;
      notifyListeners();
    }
  }

  Future changeSignIn() async {
    // Изменение статуса входа в Google-аккаунт
    _signInGoogle! ? await signOutGoogle() : await signInWithGoogle();
    calculateVariables();
  }

  void registedUser() {
    // Регистрация пользователя в приложении
    _registedInApp = true;

    notifyListeners();
  }
}
