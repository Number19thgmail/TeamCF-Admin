// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myteam.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyTeam on _MyTeamBase, Store {
  final _$unconfirmPlayerAtom = Atom(name: '_MyTeamBase.unconfirmPlayer');

  @override
  List<PlayerData> get unconfirmPlayer {
    _$unconfirmPlayerAtom.reportRead();
    return super.unconfirmPlayer;
  }

  @override
  set unconfirmPlayer(List<PlayerData> value) {
    _$unconfirmPlayerAtom.reportWrite(value, super.unconfirmPlayer, () {
      super.unconfirmPlayer = value;
    });
  }

  final _$meAtom = Atom(name: '_MyTeamBase.me');

  @override
  PlayerData get me {
    _$meAtom.reportRead();
    return super.me;
  }

  @override
  set me(PlayerData value) {
    _$meAtom.reportWrite(value, super.me, () {
      super.me = value;
    });
  }

  final _$teamAtom = Atom(name: '_MyTeamBase.team');

  @override
  Team? get team {
    _$teamAtom.reportRead();
    return super.team;
  }

  @override
  set team(Team? value) {
    _$teamAtom.reportWrite(value, super.team, () {
      super.team = value;
    });
  }

  final _$_MyTeamBaseActionController = ActionController(name: '_MyTeamBase');

  @override
  void confirm({required String uid, required bool confirm}) {
    final _$actionInfo =
        _$_MyTeamBaseActionController.startAction(name: '_MyTeamBase.confirm');
    try {
      return super.confirm(uid: uid, confirm: confirm);
    } finally {
      _$_MyTeamBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
unconfirmPlayer: ${unconfirmPlayer},
me: ${me},
team: ${team}
    ''';
  }
}
