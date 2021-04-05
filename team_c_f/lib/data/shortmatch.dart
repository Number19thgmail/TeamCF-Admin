import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';

class ShortMatch extends Match {
  String home;
  String away;
  String date;
  String time;
  String tournament;
  bool selected = false;
  ShortMatch({
    @required this.home,
    @required this.away,
    @required this.time,
    @required this.date,
    @required this.tournament,
  });
}

List<ShortMatch> data = [
  ShortMatch(
      home: 'team1',
      away: 'team2',
      time: '19:30',
      tournament: 'cup',
      date: '04.03'),
  ShortMatch(
      home: 'team3',
      away: 'team4',
      time: '19:30',
      tournament: 'cup',
      date: '04.03'),
  ShortMatch(
      home: 'team5',
      away: 'team6',
      time: '19:30',
      tournament: 'cup',
      date: '04.03'),
  ShortMatch(
      home: 'team7',
      away: 'team8',
      time: '19:30',
      tournament: 'liga',
      date: '04.03'),
];
