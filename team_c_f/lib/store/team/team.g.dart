// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Team on _TeamBase, Store {
  final _$playersAtom = Atom(name: '_TeamBase.players');

  @override
  List<PlayerData> get players {
    _$playersAtom.reportRead();
    return super.players;
  }

  @override
  set players(List<PlayerData> value) {
    _$playersAtom.reportWrite(value, super.players, () {
      super.players = value;
    });
  }

  final _$teamAtom = Atom(name: '_TeamBase.team');

  @override
  TeamData get team {
    _$teamAtom.reportRead();
    return super.team;
  }

  @override
  set team(TeamData value) {
    _$teamAtom.reportWrite(value, super.team, () {
      super.team = value;
    });
  }

  @override
  String toString() {
    return '''
players: ${players},
team: ${team}
    ''';
  }
}
