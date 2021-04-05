import 'dart:convert';

import 'package:flutter/material.dart';

class Team {
  String _docId;
  final String title;
  final List<String> members;
  int points = 0;
  int position = 1;

  set docId (String docId){
    _docId = docId;
  }

  Team({
    @required this.title,
    @required this.members,
    this.points,
    this.position,
  });

  factory Team.fromJson({Map<String, dynamic> json, String docId}) {
    Team t = Team(
      title: json['Title'],
      members: jsonDecode(json['Members']).cast<String>(),
      points: int.parse(json['Points']),
      position: int.parse(json['Position']),
    );
    t._docId = docId;
    return t;
  }
  
  Map<String, dynamic> toMap() {
    return {
      'Title': title,
      'Members': jsonEncode(members),
      'Points': points,
      'Position': position,
    };
  }
}