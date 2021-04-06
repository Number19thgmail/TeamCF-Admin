import 'package:flutter/widgets.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:collection/collection.dart';
import 'package:team_c_f/view/day.dart';
import 'package:team_c_f/view/tournament.dart';

List<TournamentView> makeTournaments({List<ShortMatch> matches}) {
  // Функция группировки матчей по соревнованиям
  Map<String, List<ShortMatch>> gr = groupBy<ShortMatch, String>(
      matches, (obj) => obj.tournament); // Группировка матчей по соревнованиям
  List<TournamentView> list = [];
  gr.forEach((key, value) {
    // Создание визуального отображения турниров
    list.add(TournamentView(
      tournament: key,
      matches: value,
    ));
  });
  return list;
}

List<DayView> makeDays(List<ShortMatch> data) {
  // Функция группировки матчей по дням
  Map<String, List<ShortMatch>> gr = groupBy<ShortMatch, String>(
      data, (obj) => obj.date); // Группировка матчей по дням
  List<DayView> list = [];
  gr.forEach((key, value) {
    // Создание визуального отображения дней
    list.add(DayView(
      date: key,
      matches: value,
    ));
  });
  return list;
}

String showPoints(int points) {
  // Функция изменения склонения слова "Очки"
  return points.toString() +
      ' ' +
      ((points % 10 == 1 && points ~/ 10 != 1)
          ? 'очко'
          : ((points - 1) % 10 - 4 < 0 && points ~/ 10 != 1)
              ? 'очка'
              : 'очков');
}

int calculatePointPerMatch({
  @required String result,
  @required String forecast,
}) {
  // Фукнция подсчета очков за матч
  List<int> res = result.split('-').map((e) => int.parse(e));
  List<int> forec = forecast.split('-').map((e) => int.parse(e));
  return res[0] - res[1] == forec[0] - forec[1]
      ? res[0] == forec[0] && res[1] == forec[1]
          ? 3
          : 2
      : (res[0] - res[1]) * (forec[0] - forec[1]) > 0
          ? 1
          : 0;
}
