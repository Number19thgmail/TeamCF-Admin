import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/operationdb.dart';

class Tournament with ChangeNotifier {
  // Класс хранящий актуальную информацию с сервера
  List<Team> allTeams = []; // Все команды
  CurrentTour current; // Текущую информацию о туре
  List<Tour> schedule = []; // Расписание
  List<Forecast> currentForecasts = []; // Прогнозы на текущий тур
  List<Player> allPlayers = []; // Все игроки

  Tournament() {
    // Конструктор
    DatabaseService().getAllTeam().then(
      (value) {
        allTeams = value;
        notifyListeners();
      },
    );
    DatabaseService().getCurrentTour().then(
      (value) {
        current = value;
        notifyListeners();
      },
    );
    DatabaseService().getAllTour().then(
      (value) {
        schedule = value;
        notifyListeners();
      },
    );
    DatabaseService().getCurrentForecasts().then(
      (value) {
        currentForecasts = value;
        notifyListeners();
      },
    );
    DatabaseService().getAllPlayers().then(
      (value) {
        allPlayers = value;
        notifyListeners();
      },
    );
  }

  List<String> get allTeamNames {
    // Получение всех неполных команд для списка при регистрации
    return allTeams.isNotEmpty
        ? allTeams
            .where((t) => t.members.length < 3)
            .map((t) => t.title)
            .toList()
        : [];
  }

  Future<List<Forecast>> getForecasts({String tour}) {
    // Получение всех прогнозов на указанный тур
    return DatabaseService().getForecasts(tour: tour).then((value) => value);
  }

  void getResults() {
    // Получение новых результатов с сервера
    DatabaseService().getResults(tour: current.tour).then((value) => schedule
        .where((element) => element.tour == current.tour)
        .first
        .matches = value);

    notifyListeners();
  }

  void updateResult() {
    // Обновление результатов на сервере
    DatabaseService().updateResults(
        tour: schedule.where((element) => element.tour == current.tour).first);
  }
}
