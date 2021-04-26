// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login on LoginBase, Store {
  Computed<bool>? _$updatedLoginStatusComputed;

  @override
  bool get updatedLoginStatus => (_$updatedLoginStatusComputed ??=
          Computed<bool>(() => super.updatedLoginStatus,
              name: 'LoginBase.updatedLoginStatus'))
      .value;

  final _$loginAtom = Atom(name: 'LoginBase.login');

  @override
  bool get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(bool value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  final _$userNameAtom = Atom(name: 'LoginBase.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$loginStatusAtom = Atom(name: 'LoginBase.loginStatus');

  @override
  ObservableFuture<bool> get loginStatus {
    _$loginStatusAtom.reportRead();
    return super.loginStatus;
  }

  @override
  set loginStatus(ObservableFuture<bool> value) {
    _$loginStatusAtom.reportWrite(value, super.loginStatus, () {
      super.loginStatus = value;
    });
  }

  final _$googleLoginAsyncAction = AsyncAction('LoginBase.googleLogin');

  @override
  Future<bool> googleLogin() {
    return _$googleLoginAsyncAction.run(() => super.googleLogin());
  }

  final _$googleLogoutAsyncAction = AsyncAction('LoginBase.googleLogout');

  @override
  Future<bool> googleLogout() {
    return _$googleLogoutAsyncAction.run(() => super.googleLogout());
  }

  final _$LoginBaseActionController = ActionController(name: 'LoginBase');

  @override
  void changeName(String text) {
    final _$actionInfo =
        _$LoginBaseActionController.startAction(name: 'LoginBase.changeName');
    try {
      return super.changeName(text);
    } finally {
      _$LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLoginStatus(dynamic status) {
    final _$actionInfo = _$LoginBaseActionController.startAction(
        name: 'LoginBase.changeLoginStatus');
    try {
      return super.changeLoginStatus(status);
    } finally {
      _$LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
login: ${login},
userName: ${userName},
loginStatus: ${loginStatus},
updatedLoginStatus: ${updatedLoginStatus}
    ''';
  }
}
