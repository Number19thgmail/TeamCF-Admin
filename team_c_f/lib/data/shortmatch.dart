import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';

class ShortMatch extends Match {
  // Основаная информация о матче, используется при выборе матчей
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
