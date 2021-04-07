import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/match.dart';

class DatabaseService {
  final CollectionReference currentCollection =
      FirebaseFirestore.instance.collection('current');
  final CollectionReference forecastsCollection =
      FirebaseFirestore.instance.collection('forecasts');
  final CollectionReference playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference scheduleCollection =
      FirebaseFirestore.instance.collection('schedule');
  final CollectionReference teamsCollection =
      FirebaseFirestore.instance.collection('teams');

  Future makeForecast({Forecast forecast}) async {
    // Создание прогноза
    return forecastsCollection
        .add(forecast.toMap())
        .then((response) => forecast.docId = response.id);
  }

  Future<List<Player>> getAllPlayers() async {
    // Получение списка всех участников
    return playersCollection.get().then(
          (response) => response.docs
              .map(
                (e) => Player.fromJson(
                  json: e.data(),
                  docId: e.id,
                ),
              )
              .toList(),
        );
  }

//!(для редактирования прогноза)
  Future<Forecast> getForecast({String uid, String tour}) async {
    // Получение прогноза указанного пользователя на указанный тур
    Query query = forecastsCollection
        .where('UserId', isEqualTo: uid)
        .where('Tour', isEqualTo: tour);
    return query.get().then(
          (QuerySnapshot value) => value.docs
              .map(
                (DocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .first,
        );
  }

  Future<List<Forecast>> getForecasts({String tour}) async {
    // Получение всех прогноз на указанный тур
    Query query = forecastsCollection.where('Tour', isEqualTo: tour);
    return query.get().then(
          (QuerySnapshot value) => value.docs
              .map(
                (DocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<List<Forecast>> getCurrentForecasts() async {
    // Получение всех прогнохов на текущий тур
    Query query = forecastsCollection.where('Tour',
        isEqualTo: CurrentTour.fromJson(
                json: (await currentCollection.get()).docs.first.data())
            .tour);
    return query.get().then(
          (QuerySnapshot value) => value.docs
              .map(
                (DocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future registrationTeam({Team team}) {
    // Регистрация команды
    return teamsCollection
        .add(team.toMap())
        .then((response) => team.docId = response.id);
  }

  Future<bool> userExists({String userId}) {
    // Проверка существует ли пользователь с указанным Google-аккаунтом
    return playersCollection
        .where('UserId', isEqualTo: userId)
        .get()
        .then((value) => value.docs.length == 1);
  }

  Future<bool> checkTeamName({String name}) {
    // Проверка названия команды на уникальность
    return teamsCollection
        .where('Title', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }

  Future registrationPlayer({Player player}) {
    // Регистрация игрока
    return playersCollection.add(player.toMap());
  }

  Future<List<String>> getAllTeamNames() {
    // Получение списка названий всех команд для выбора участником своей команды
    return teamsCollection.get().then((response) {
      return response.docs
          .map((element) =>
              Team.fromJson(json: element.data(), docId: element.id).title)
          .toList();
    });
  }

  Future<List<Team>> getAllTeam() {
    // Получение всех команд
    return teamsCollection.get().then(
          (response) => response.docs
              .map(
                (element) => Team.fromJson(
                  json: element.data(),
                  docId: element.id,
                ),
              )
              .toList(),
        );
  }

  Future<CurrentTour> getCurrentTour() {
    // Получение информации о текущем туре
    return currentCollection.get().then(
          (response) => CurrentTour.fromJson(
            json: response.docs.first.data(),
          ),
        );
  }

  Future<List<Tour>> getAllTour() {
    // Получение информации обо всех турах
    return scheduleCollection.get().then(
          (response) => response.docs
              .map(
                (element) => Tour.fromJson(
                  json: element.data(),
                  docId: element.id,
                ),
              )
              .toList(),
        );
  }

//! Использовать для обновления результатов с сервера
  Future<List<Match>> getResults({String tour}) {
    // Получение результатов матчей
    return scheduleCollection
        .where(
          'Tour',
          isEqualTo: tour,
        )
        .get()
        .then(
          (response) => Tour.fromJson(
            json: response.docs.first.data(),
            docId: response.docs.first.id,
          ).matches,
        );
  }

  void updatePlayer({@required Player player}) { // Обновление информации об игроке
    playersCollection.doc(player.docId).update(
          player.toMap(),
        );
  }
  
  void updateTeam({@required Team team}) { // Обновление информации о команде
    teamsCollection.doc(team.docId).update(
          team.toMap(),
        );
  }

//! Обновление результатов на сервера
  void updateResults({Tour tour}) {
    // Обновление результатов матчей конкретного тура
    scheduleCollection.doc(tour.docId).update(
          tour.toMap(),
        );
  }
}
