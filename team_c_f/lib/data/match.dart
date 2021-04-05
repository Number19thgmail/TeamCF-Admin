import 'package:flutter/material.dart';

class Match {
  final String home;
  final String away;
  final String date;
  final String time;
  final String score;
  final bool started;

  Match({
    @required this.home,
    @required this.away,
    @required this.time,
    @required this.date,
    @required this.score,
    @required this.started,
  });

  factory Match.fromJson({Map<String, dynamic> json, String docId}) {
    return Match(
      home: json['Home'],
      away: json['Away'],
      date: json['Date'],
      time: json['Time'],
      score: json['Score'],
      started: json['Started'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Home': home,
      'Away': away,
      'Date': date,
      'Time': time,
      'Score': score,
      'Started': started,
    };
  }
}
