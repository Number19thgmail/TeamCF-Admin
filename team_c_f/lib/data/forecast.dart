import 'dart:convert';

import 'package:flutter/material.dart';

class Forecast {
  String _docId;
  final String userId;
  final String tour;
  final List<String> rate;
  int _points;

  Forecast({
    @required this.userId,
    @required this.tour,
    @required this.rate,
  });

  set docId(String docId) {
    _docId = docId;
  }

  int get points => _points;

  factory Forecast.fromJson({Map<String, dynamic> json, String docId}) {
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
    return {
      'UserId': userId,
      'Tour': tour,
      'Team': jsonEncode(rate),
      'Points': _points,
    };
  }
}// String tour = "1";
              // String userId = user.uid;
              // List<String> rate = [
              //   '0-0',
              //   '1-0',
              //   '0-1',
              //   '1-1',
              //   '2-1',
              //   '1-2',
              //   '2-2',
              //   '3-2',
              //   '2-3',
              //   '3-3',
              // ];
              // DatabaseService().makeForecast(
              //     forecast: Forecast(tour: tour, userId: userId, rate: rate));