import 'dart:convert';

import 'package:flutter/material.dart';

class Team {
  // Информация о команде
  String _docId; // Идентификатор документа с командой на сервере
  final String title; // Название команды
  final List<String> members; // Список участников
  int points = 0; // Количество очков в чемпионате
  int position = 1; // Позиция в турнирной таблице

  set docId(String docId) {
    _docId = docId;
  }

  Team({
    // Конструктор
    @required this.title,
    @required this.members,
    this.points,
    this.position,
  });

  factory Team.fromJson({Map<String, dynamic> json, String docId}) {
    // Именованный конструктор, используемый при десериализации
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
    // Функция для сериализации
    return {
      'Title': title,
      'Members': jsonEncode(members),
      'Points': points.toString(),
      'Position': position.toString(),
    };
  }
}
