import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';

class ShortMatch extends Match {
  // Основаная информация о матче, используется при выборе матчей
  String tournament;
  bool selected = false;
  ShortMatch({
    String home,
    String away,
    String time,
    String date,
    @required this.tournament,
  }) : super(
          home: home,
          away: away,
          time: time,
          date: date,
          started: false,
          score: '',
        );
}
