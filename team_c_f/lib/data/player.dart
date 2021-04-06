import 'package:flutter/material.dart';

class Player {
  // Информация об участнике
  String docId; // Идентификатор документа с информацией об участнике
  final String name; // Имя и фамилия участника
  String _uid; // Идентификатор Google-аккаунта участника
  final bool capitan; // Флаг капитана
  bool confirmed = false; // Флаг подтверждения участия в команде
  final String team; // Название команды
  int position; // Позиция в списке бомбардиров
  int points; // Количество набранных очков

  Player({
    // Конструктор
    @required this.name,
    String uid,
    @required this.capitan,
    @required this.team,
    this.confirmed,
    this.points = 0,
    this.position = 1,
  }) {
    this._uid = uid;
  }

  bool itIsMe({String uid}) {
    // Проверка It's me?
    return uid == _uid;
  }

  void confirm() {
    // Подтверждение участия в команде
    confirmed = true;
    //! отновление информации на сервере об утверждении
  }

  factory Player.fromJson({Map<String, dynamic> json, String docId}) {
    // Именованный конструктор для десериализации
    Player p = Player(
      name: json['Name'],
      uid: json['UserId'],
      capitan: json['Capitan'] as bool,
      team: json['Team'],
      confirmed: json['Confirmed'] as bool,
      position: int.parse(json['Position']),
      points: int.parse(json['Points']),
    );
    p.docId = docId;
    return p;
  }

  Map<String, dynamic> toMap() {
    // Функция для сериализации
    return {
      'Name': name,
      'UserId': _uid,
      'Capitan': capitan,
      'Team': team,
      'Confirmed': confirmed,
      'Position': position.toString(),
      'Points': points.toString(),
    };
  }
}
