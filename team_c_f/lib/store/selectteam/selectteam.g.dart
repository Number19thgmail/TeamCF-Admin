// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectteam.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SelectTeam on _SelectTeamBase, Store {
  Computed<Future<bool>>? _$availableTeamNameComputed;

  @override
  Future<bool> get availableTeamName => (_$availableTeamNameComputed ??=
          Computed<Future<bool>>(() => super.availableTeamName,
              name: '_SelectTeamBase.availableTeamName'))
      .value;

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
  String toString() {
    return '''
teamName: ${teamName},
lastTeamName: ${lastTeamName},
capitan: ${capitan},
availableTeamName: ${availableTeamName}
    ''';
  }
}
