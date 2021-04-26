import 'package:team_c_f/old/data/shortmatch.dart';
import 'package:collection/collection.dart';
import 'package:team_c_f/old/view/day.dart';
import 'package:team_c_f/old/view/tournament.dart';

List<TournamentView> makeTournaments({required List<ShortMatch> matches}) {
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
  // Функция изменения склонения слова "N очков"
  return points.toString() +
      ' ' +
      ((points % 10 == 1 && points ~/ 10 != 1)
          ? 'очко'
          : ((points - 1) % 10 - 4 < 0 && points ~/ 10 != 1)
              ? 'очка'
              : 'очков');
}

String showRegisterTeam(int count) {
  // Функция изменения склонения слова "Зарегистрировано"
  return (count % 10 == 1 && count ~/ 10 != 1)
      ? 'Зарегистрирована'
      : 'Зарегистрировано';
}

String showFullTeam(int count) {
  // Функция изменения склонения выражения "Готово к участию"
  return (count % 10 == 1 && count ~/ 10 != 1)
      ? 'Готова к участию'
      : 'Готово к участию';
}

String showTeam(int points) {
  // Функция изменения склонения слова "N команд"
  return points.toString() +
      ' ' +
      ((points % 10 == 1 && points ~/ 10 != 1)
          ? 'команда'
          : ((points - 1) % 10 - 4 < 0 && points ~/ 10 != 1)
              ? 'команды'
              : 'команд');
}

String showMatches({required int teams, required int circles}) {
  int matches = (teams * (teams - 1) / 2).round() * circles;
  return matches.toString() +
      ' ' +
      ((matches % 10 == 1 && matches ~/ 10 != 1)
          ? 'матч'
          : ((matches - 1) % 10 - 4 < 0 && matches ~/ 10 != 1)
              ? 'матча'
              : 'матчей');
}

String showTours({required int teams, required int circles}) {
  int tours = circles * (teams.isEven ? teams - 1 : teams);
  return tours.toString() +
      ' ' +
      ((tours % 10 == 1 && tours ~/ 10 != 1)
          ? 'тур'
          : ((tours - 1) % 10 - 4 < 0 && tours ~/ 10 != 1)
              ? 'тура'
              : 'туров');
}

int calculatePointPerMatch({
  required String result,
  required String forecast,
}) {
  // Фукнция подсчета очков за матч
  List<int> res = result.split('-').map((e) => int.parse(e)).toList();
  List<int> forec = forecast.split('-').map((e) => int.parse(e)).toList();
  return res[0] - res[1] == forec[0] - forec[1]
      ? res[0] == forec[0] && res[1] == forec[1]
          ? 3
          : 2
      : (res[0] - res[1]) * (forec[0] - forec[1]) > 0
          ? 1
          : 0;
}
