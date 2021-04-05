import 'dart:convert';
import 'package:team_c_f/data/match.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tour {
  String docId;
  final String tour;
  final List<String> pair;
  List<Match> matches;
  DateTime deadline;
  DateTime ending;
  bool _show;

  Tour.basic({
    @required this.tour,
    @required this.pair,
  });

  Tour({
    @required this.tour,
    @required this.pair,
    @required this.matches,
    @required this.deadline,
    @required this.ending,
  });

  bool get show => _show;

  factory Tour.fromJson({Map<String, dynamic> json, String docId}) {
    Tour t = Tour(
      tour: json['Tour'],
      pair: jsonDecode(json['Pair']),
      matches: List<Match>.from(json['Matchs']),
      deadline: DateTime.parse(json['Deadline']),
      ending: DateTime.parse(json['Ending']),
    );
    t._show = json['Show'] as bool;
    t.docId = docId;
    return t;
  }

  Map<String, dynamic> toMap() {
    return {
      'Tour': tour,
      'Pair': jsonEncode(pair),
      'Matchs': jsonEncode(matches.map((e) => e.toString()).toList()),
      'Deadline': DateFormat('yyyy-MM-dd HH:mm').format(deadline),
      'Ending': DateFormat('yyyy-MM-dd HH:mm').format(ending),
      'Show': _show,
    };
  }
}