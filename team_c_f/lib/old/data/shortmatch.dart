import 'package:flutter/material.dart';
import 'package:team_c_f/old/data/match.dart';

class ShortMatch extends Match {
  // Основаная информация о матче, используется при выборе матчей
  String tournament;
  bool selected = false;
  ShortMatch({
    required String home,
    required String away,
    required String time,
    required String date,
    required this.tournament,
  }) : super(
          home: home,
          away: away,
          time: time,
          date: date,
          started: false,
          score: '',
        );
}

class DataMatch extends ChangeNotifier {
  List<ShortMatch> _data = []; // Список матчей

  List<ShortMatch> get data => _data;

  void add(List<ShortMatch> curr) {
    _data = [..._data, ...curr];

    notifyListeners();
  }

  void clear() {
    _data.clear();
    notifyListeners();
  }

  void selectMatch(ShortMatch match,bool key){
    match.selected = key;
    notifyListeners();
  }
}
