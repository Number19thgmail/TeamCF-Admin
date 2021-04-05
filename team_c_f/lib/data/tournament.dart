import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/operationdb.dart';

class Tournament with ChangeNotifier {
  List<Team> allTeams = [];
  CurrentTour current;
  List<Tour> schedule = [];
  List<Forecast> currentForecasts = [];
  List<Player> allPlayers = [];

  void initInfo() {
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
    return allTeams.isNotEmpty ? allTeams.map((t) => t.title).toList() : [];
  }

  void downloadForecasts({String tour}) {
    DatabaseService()
        .getForecasts(tour: tour)
        .then((value) => currentForecasts = value);

    notifyListeners();
  }

  void getResults() {
    DatabaseService().getResults(tour: current.tour).then((value) => schedule
        .where((element) => element.tour == current.tour)
        .first
        .matches = value);

    notifyListeners();
  }

  void updateResult() {
    DatabaseService().updateResults(
        tour: schedule.where((element) => element.tour == current.tour).first);
  }
}
