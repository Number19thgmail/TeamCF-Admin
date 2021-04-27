// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectteam.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SelectTeam on _SelectTeamBase, Store {
  final _$teamNameAtom = Atom(name: '_SelectTeamBase.teamName');

  @override
  String get teamName {
    _$teamNameAtom.reportRead();
    return super.teamName;
  }

  @override
  set teamName(String value) {
    _$teamNameAtom.reportWrite(value, super.teamName, () {
      super.teamName = value;
    });
  }

  final _$enableNameAtom = Atom(name: '_SelectTeamBase.enableName');

  @override
  bool get enableName {
    _$enableNameAtom.reportRead();
    return super.enableName;
  }

  @override
  set enableName(bool value) {
    _$enableNameAtom.reportWrite(value, super.enableName, () {
      super.enableName = value;
    });
  }

  final _$lastTeamNameAtom = Atom(name: '_SelectTeamBase.lastTeamName');

  @override
  String get lastTeamName {
    _$lastTeamNameAtom.reportRead();
    return super.lastTeamName;
  }

  @override
  set lastTeamName(String value) {
    _$lastTeamNameAtom.reportWrite(value, super.lastTeamName, () {
      super.lastTeamName = value;
    });
  }

  final _$capitanAtom = Atom(name: '_SelectTeamBase.capitan');

  @override
  bool get capitan {
    _$capitanAtom.reportRead();
    return super.capitan;
  }

  @override
  set capitan(bool value) {
    _$capitanAtom.reportWrite(value, super.capitan, () {
      super.capitan = value;
    });
  }

  final _$selectedTeamAtom = Atom(name: '_SelectTeamBase.selectedTeam');

  @override
  String? get selectedTeam {
    _$selectedTeamAtom.reportRead();
    return super.selectedTeam;
  }

  @override
  set selectedTeam(String? value) {
    _$selectedTeamAtom.reportWrite(value, super.selectedTeam, () {
      super.selectedTeam = value;
    });
  }

  final _$allTeamNamesAtom = Atom(name: '_SelectTeamBase.allTeamNames');

  @override
  List<String> get allTeamNames {
    _$allTeamNamesAtom.reportRead();
    return super.allTeamNames;
  }

  @override
  set allTeamNames(List<String> value) {
    _$allTeamNamesAtom.reportWrite(value, super.allTeamNames, () {
      super.allTeamNames = value;
    });
  }

  final _$assertTeamAsyncAction = AsyncAction('_SelectTeamBase.assertTeam');

  @override
  Future<bool> assertTeam() {
    return _$assertTeamAsyncAction.run(() => super.assertTeam());
  }

  final _$registrateTeamAsyncAction =
      AsyncAction('_SelectTeamBase.registrateTeam');

  @override
  Future<dynamic> registrateTeam() {
    return _$registrateTeamAsyncAction.run(() => super.registrateTeam());
  }

  final _$_SelectTeamBaseActionController =
      ActionController(name: '_SelectTeamBase');

  @override
  void changeTeam(String text) {
    final _$actionInfo = _$_SelectTeamBaseActionController.startAction(
        name: '_SelectTeamBase.changeTeam');
    try {
      return super.changeTeam(text);
    } finally {
      _$_SelectTeamBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCapitan(bool? value) {
    final _$actionInfo = _$_SelectTeamBaseActionController.startAction(
        name: '_SelectTeamBase.changeCapitan');
    try {
      return super.changeCapitan(value);
    } finally {
      _$_SelectTeamBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selestTeam(String? name) {
    final _$actionInfo = _$_SelectTeamBaseActionController.startAction(
        name: '_SelectTeamBase.selestTeam');
    try {
      return super.selestTeam(name);
    } finally {
      _$_SelectTeamBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
teamName: ${teamName},
enableName: ${enableName},
lastTeamName: ${lastTeamName},
capitan: ${capitan},
selectedTeam: ${selectedTeam},
allTeamNames: ${allTeamNames}
    ''';
  }
}
