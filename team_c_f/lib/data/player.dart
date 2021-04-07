import 'package:flutter/material.dart';

class Player {
  // Информация об участнике
  String docId; // Идентификатор документа с информацией об участнике
  final String name; // Имя и фамилия участника
  String uid; // Идентификатор Google-аккаунта участника
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
    this.uid = uid;
  }

  bool itIsMe({String userId}) {
    // Проверка It's me?
    return uid == userId;
  }

  void confirm() {
    // Подтверждение участия в команде
    confirmed = true;
    //! обновление информации на сервере об утверждении
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
      'UserId': uid,
      'Capitan': capitan,
      'Team': team,
      'Confirmed': confirmed,
      'Position': position.toString(),
      'Points': points.toString(),
    };
  }
}
