// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myteam.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyTeam on _MyTeamBase, Store {
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

  @override
  String toString() {
    return '''
me: ${me},
team: ${team}
    ''';
  }
}
