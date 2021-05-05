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

  final _$infoAtom = Atom(name: 'LoginBase.info');

  @override
  InfoData? get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(InfoData? value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
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

  final _$registrateInAppAtom = Atom(name: 'LoginBase.registrateInApp');

  @override
  bool get registrateInApp {
    _$registrateInAppAtom.reportRead();
    return super.registrateInApp;
  }

  @override
  set registrateInApp(bool value) {
    _$registrateInAppAtom.reportWrite(value, super.registrateInApp, () {
      super.registrateInApp = value;
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

  final _$validateInAppAsyncAction = AsyncAction('LoginBase.validateInApp');

  @override
  Future<dynamic> validateInApp() {
    return _$validateInAppAsyncAction.run(() => super.validateInApp());
  }

  final _$LoginBaseActionController = ActionController(name: 'LoginBase');

  @override
  void initInfo() {
    final _$actionInfo =
        _$LoginBaseActionController.startAction(name: 'LoginBase.initInfo');
    try {
      return super.initInfo();
    } finally {
      _$LoginBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void clearData() {
    final _$actionInfo =
        _$LoginBaseActionController.startAction(name: 'LoginBase.clearData');
    try {
      return super.clearData();
    } finally {
      _$LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
info: ${info},
userName: ${userName},
registrateInApp: ${registrateInApp},
loginStatus: ${loginStatus},
updatedLoginStatus: ${updatedLoginStatus}
    ''';
  }
}
