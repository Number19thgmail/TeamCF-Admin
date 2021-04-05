import 'package:flutter/material.dart';

class CurrentTour {
  final String tour;
  final String tournament;

  CurrentTour({
    @required this.tour,
    @required this.tournament,
  });

  factory CurrentTour.fromJson({Map<String, dynamic> json}) {
    return CurrentTour(
      tour: json['Tour'],
      tournament: json['Tournament'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Tour': tour,
      'Tournament': tournament,
    };
  }
}
