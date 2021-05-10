import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/team.dart';
import 'package:team_c_f/models/tour.dart';

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

String showGoals(int goals) {
  // Функция изменения склонения слова "N забытых"
  return goals.toString() +
      ' ' +
      ((goals % 10 == 1 && goals ~/ 10 != 1) ? 'забитый' : 'забитых');
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

String showMatches({required int matches}) {
  return matches.toString() +
      ' ' +
      ((matches % 10 == 1 && matches ~/ 10 != 1)
          ? 'матч'
          : ((matches - 1) % 10 - 4 < 0 && matches ~/ 10 != 1)
              ? 'матча'
              : 'матчей');
}

String showTours({required int tours}) {
  return tours.toString() +
      ' ' +
      ((tours % 10 == 1 && tours ~/ 10 != 1)
          ? 'тур'
          : ((tours - 1) % 10 - 4 < 0 && tours ~/ 10 != 1)
              ? 'тура'
              : 'туров');
}

List<TourData> createSchedule(int circles) {
  List<TeamData> registTeam =
      Data.teams.where((TeamData team) => team.players.length == 3).toList();
  List<String> teams =['1', '2', '3', '4', '5']; 
  // registTeam
  //     .map((TeamData team) => team.name)
  //     .toList(); //['1', '2', '3', '4', '5'];
  List<TourData> curr = [];
  int count = 5;//registTeam.length;
  int tour = (count.isEven ? count - 1 : count);
  for (int q = 0; q < circles; q++) {
    for (int i = 0; i < tour; i++) {
      List<List<String>> pair = [];
      for (int j = 0; j < count ~/ 2; j++) {
        List<String> match = [];
        int k = count.isEven ? j : j + 1;
        int home = i.isOdd
            ? k == 0
                ? count - 1
                : (count ~/ 2 + i ~/ 2 + k + (count.isEven ? 0 : 1)) %
                    (count.isOdd ? count : count - 1)
            : k + i ~/ 2;
        int away = i.isOdd
            ? count ~/ 2 + i ~/ 2 - j
            : k == 0
                ? count - 1
                : (count + i ~/ 2 - 1 - k + (count.isEven ? 0 : 1)) %
                    (count.isOdd ? count : count - 1);
        if (q.isEven) {
          match.add(teams[home]);
          match.add(teams[away]);
        } else {
          match.add(teams[away]);
          match.add(teams[home]);
        }
        pair.add(match);
      }
      curr.add(
        TourData.all(round: (i + 1 + q * tour).toString(), team: pair),
      );
    }
  }
  return [...curr];
}
