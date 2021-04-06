import 'package:flutter/material.dart';

class CurrentTour { // Класс с данными о текущем туре
  final String tour; // Номер или стадия текущего тура
  final String tournament; // Название текущей стадии

  CurrentTour({ // Базовый конструктор
    @required this.tour, 
    @required this.tournament,
  });

  factory CurrentTour.fromJson({Map<String, dynamic> json}) { // Именованный конструктор, используется для десериализации
    return CurrentTour(
      tour: json['Tour'],
      tournament: json['Tournament'],
    );
  }

  Map<String, dynamic> toMap() { // Функция, используется для сериализации
    return {
      'Tour': tour,
      'Tournament': tournament,
    };
  }
}
