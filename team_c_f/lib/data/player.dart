import 'package:flutter/material.dart';

class Player {
  String docId;
  final String name;
  String _uid;
  final bool capitan;
  bool confirmed = false;
  final String team;
  int position;
  int points;

  Player({
    @required this.name,
    String uid,
    @required this.capitan,
    @required this.team,
    this.confirmed,
    this.points = 0,
    this.position = 1,
  }) {
    this._uid = uid;
  }

  bool itIsMe({String uid}){
    return uid == _uid;
  }

  void confirm() {
    confirmed = true;
  }

  factory Player.fromJson({Map<String, dynamic> json, String docId}) {
    Player p = Player(
      name: json['Name'],
      uid: json['UserId'],
      capitan: json['Capitan'] as bool,
      team: json['Team'],
      confirmed: json['Confirmed'] as bool,
      position: int.parse(json['Position']),
      points: int.parse(json['Points']),
    );
    p.docId = docId;
    return p;
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'UserId': _uid,
      'Capitan': capitan,
      'Team': team,
      'Confirmed': confirmed,
      'Position': position,
      'Points': points,
    };
  }
}
