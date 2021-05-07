import 'package:flutter/material.dart';
import 'package:team_c_f/models/currenttour.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/servises/data.dart';

class Data with ChangeNotifier {
  bool downloadSuccessful = false;

  Data() {
    DataService().initData().then((result) {
      sortTour();
      sortData();
      downloadSuccessful = result;
      notifyListeners();
    });
  }

  static late CurrentTourData currentTour;
  static late List<PlayerData> players;
  static late List<TeamData> teams;
  static late List<TourData> tours;

  static void sortTour() {
    tours.sort((TourData a, b) =>
        a.round.compareTo(b.round)); // сортировка туров по порядку
  }

  static void sortData() {
    players.sort((PlayerData a, b) => b.goals
        .compareTo(a.goals)); // сортировка участников по количеству забитых
    players.forEach(
      (PlayerData p) {
        p.prevPosition = players.indexOf(p) + 1;
      },
    ); // указание текущей позиции игрока

    tours.forEach(
      (TourData tour) {
        int round = tours.indexOf(tour);
        tour.team.forEach(
          (List<String> pair) {
            TeamData home =
                teams.where((TeamData team) => team.name == pair[0]).single;
            TeamData away =
                teams.where((TeamData team) => team.name == pair[1]).single;
            if (home.goal[round] == null && away.goal[round] == null) {
              home.lose++;
              away.lose++;
            } else if (home.goal[round] == null) {
              home.lose++;
              away.win++;
              home.missed += away.goal[round]!;
            } else if (away.goal[round] == null) {
              away.lose++;
              home.win++;
              away.missed += home.goal[round]!;
            } else {
              int goalHome = home.goal[round]!;
              int goalAway = away.goal[round]!;
              home.missed += goalAway;
              away.missed += goalHome;
              if (goalHome > goalAway) {
                home.win++;
                away.lose++;
              } else if (goalAway > goalHome) {
                away.win++;
                home.lose++;
              } else {
                home.draw++;
                away.draw++;
              }
            }
          },
        );
      },
    ); // определение wdl для команд и количества пропущенных
    teams.sort((TeamData a, b) => (b.goals - b.missed)
        .compareTo(a.goals - a.missed)); // сортировка команд по разнице забитых
    teams.sort((TeamData a, b) =>
        b.win.compareTo(a.win)); // сортировка команд по количеству побед
    teams.sort((TeamData a, b) =>
        b.goals.compareTo(a.goals)); // сортировка команд по количеству забитых
    teams.sort((TeamData a, b) =>
        b.points.compareTo(a.points)); // сортировка команд по количеству очков
    teams.forEach(
      (TeamData t) {
        t.prevPosition = teams.indexOf(t) + 1;
      },
    ); // указание текущей позиции команды
  }
  // static void initTeams({required List<TeamData> data}){
  //   data.sort((TeamData a, b) => a.points.compareTo(b.points));
  // }

  // Текущий тур (подписка)
  // {
  //     *получаемые поля
  //     номер тура (строка).
  // }
  // Игроки
  // {
  //     *получаемые поля
  //     идентификатор (строка),
  //     имя (строка),
  //     название команды (строка),
  //     лист забитых за тур (лист интов, null при пропуске тура).

  //     *вычисляемые поля
  //     максимум забитых за тур (инт),
  //     количество забитых за все матчи (инт),
  //     позиция (инт).
  // }
  // Команды
  // {
  //     *получаемые поля
  //     название (строка),
  //     идентификатор капитана (строка)
  //     лист участников (лист строк с идентификаторами).

  //     *вычисляемые поля
  //     максимум забитых за тур (инт)
  //     количество забитых за все матчи (инт),
  //     количество пропущенных за все матчи (инт),
  //     победы (инт),
  //     ничьи (инт),
  //     поражения (инт),
  //     очки (инт),
  //     позиция (инт).
  // }
  // Туры
  // {
  //     *получаемые поля
  //     номер тура (строка),
  //     лист участников (лист типа: команда, забитые).
  // }
}
