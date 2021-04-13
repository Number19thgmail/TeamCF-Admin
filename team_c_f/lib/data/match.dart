import 'package:flutter/material.dart';

class Match {
  // Информация о матче
  final String home; // Хозяева
  final String away; // Гости
  final String date; // Дата матча
  final String time; // Время матча
  final String score; // Счет
  final bool started; // Флаг начала матча

  Match({
    // Базовый конструктов
    @required this.home,
    @required this.away,
    @required this.time,
    @required this.date,
    @required this.score,
    @required this.started,
  });

  factory Match.fromJson({Map<String, dynamic> json}) {
    // Именованный конструктор, используемый при десериализации
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
    // Фукнция сериализации
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
