import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';
import 'package:team_c_f/servise/make.dart';

class Forecast {
  // Информация о прогнозе
  String _docId; // Идентификатор документа с прогнозом
  final String
      userId; // Идентификатор Google-аккаунта участника оставившего прогноз
  final String tour; // Номер тура
  final List<String> rate; // Список прогнозов
  int _points; // Количество набранных очков

  Forecast({
    // Конструктор
    @required this.userId,
    @required this.tour,
    @required this.rate,
  });

  set docId(String docId) {
    _docId = docId;
  }

  int get points => _points;

  factory Forecast.fromJson({Map<String, dynamic> json, String docId}) {
    // Именованный конструктор для десериализации
    Forecast f = Forecast(
      userId: json['UserId'],
      tour: json['Tour'],
      rate: jsonDecode(json['Team']).cast<String>(),
    );
    f._points = int.parse(json['Points']);
    f._docId = docId;
    return f;
  }

  Map<String, dynamic> toMap() {
    // Функция для десериализации
    return {
      'UserId': userId,
      'Tour': tour,
      'Team': jsonEncode(rate),
      'Points': _points,
    };
  }

  void calculatePoints(List<Match> results) {
    // Функция подсчета очков игрока по результатам матчей
    _points = 0;
    results.forEach(
      (match) {
        if (match.started) {
          _points += calculatePointPerMatch(
              result: match.score, forecast: rate[results.indexOf(match)]);
        }
      },
    );
  }
}
