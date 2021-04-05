import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/operationdb.dart';

class Tournament with ChangeNotifier {
  List<Team> allTeams;
  CurrentTour current;
  List<Tour> schedule;
  List<Forecast> currentForecasts;
  List<Player> allPlayers;

  Tournament() {
    DatabaseService().getAllTeam().then((value) => allTeams = value);
    DatabaseService().getCurrentTour().then((value) => current = value);
    DatabaseService().getAllTour().then((value) => schedule = value);
    DatabaseService()
        .getCurrentForecasts()
        .then((value) => currentForecasts = value);
    DatabaseService().getAllPlayers().then((value) => allPlayers = value);
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
