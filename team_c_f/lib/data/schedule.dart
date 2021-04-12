import 'dart:convert';
import 'package:team_c_f/data/match.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tour {
  // Информация о туре
  String docId; // Идентификатор документа с информацией о туре
  final String tour; // Номер тура
  final List<String> pair; // Список участников тура
  List<Match> matches = []; // Список матчей тура
  DateTime deadline = DateTime(2040); // Время дедлайна
  DateTime ending =
      DateTime(2040); // Время завершения последнего матча + 2 часа
  bool _show = false; // Флаг показа прогнозов //! изменяется администратором

  Tour.basic({
    // Именованный конструктор, используемый администраторами для создания расписания
    @required this.tour,
    @required this.pair,
  });

  Tour({
    // Конструктор
    @required this.tour,
    @required this.pair,
    @required this.matches,
    @required this.deadline,
    @required this.ending,
  });

  bool get show => _show;

  factory Tour.fromJson({Map<String, dynamic> json, String docId}) {
    // Именованный конструктор, используемый для десериализации
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
    // Фукнция сериализации
    return {
      'Tour': tour,
      'Pair': jsonEncode(pair),
      'Matchs': jsonEncode(matches.map((e) => e.toMap()).toList()),
      'Deadline': DateFormat('yyyy-MM-dd HH:mm').format(deadline),
      'Ending': DateFormat('yyyy-MM-dd HH:mm').format(ending),
      'Show': _show,
    };
  }
}
