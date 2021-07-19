import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/old/data/currenttour.dart';
import 'package:team_c_f/old/data/forecast.dart';
import 'package:team_c_f/old/data/player.dart';
import 'package:team_c_f/old/data/schedule.dart';
import 'package:team_c_f/old/data/team.dart';
import 'package:team_c_f/old/data/match.dart';

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

  Stream<CurrentTour> getCurrentTour() {
    // Получение информации о текущем туре
    return currentCollection.snapshots().map(
          (QuerySnapshot data) => CurrentTour.fromJson(
            json: data.docs.first.data(),
          ),
        );
  }

  Future<List<Player>> getAllPlayers() {
    // Получение списка всех участников
    return playersCollection.get().then(
          (QuerySnapshot data) => data.docs
              .map(
                (QueryDocumentSnapshot doc) => Player.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Forecast>> getCurrentForecasts({required String stage}) {
    // Получение всех прогнозов на текущий тур
    return forecastsCollection
        .where(
          'Tour',
          isEqualTo: stage,
        )
        .snapshots()
        .map(
          (QuerySnapshot data) => data.docs
              .map(
                (QueryDocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<List<Team>> getAllTeam() {
    // Получение всех команд
    return teamsCollection.get().then(
          (QuerySnapshot data) => data.docs
              .map(
                (QueryDocumentSnapshot doc) => Team.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Stream<Tour> getTour({required String stage}) {
    // Получение информации о туре stage
    return scheduleCollection
        .where(
          'Tour',
          isEqualTo: stage,
        )
        .snapshots()
        .map(
          (QuerySnapshot data) => Tour.fromJson(
            json: data.docs.first.data(),
            docId: data.docs.first.id,
          ),
        );
  }

  Future<List<Tour>> getAllTour() {
    // Получение информации обо всех турах
    return scheduleCollection.get().then(
          (QuerySnapshot data) => data.docs
              .map(
                (QueryDocumentSnapshot doc) => Tour.fromJson(
                  json: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<bool> userExists({required String userId}) {
    // Проверка существует ли пользователь с указанным Google-аккаунтом
    return playersCollection
        .where('UserId', isEqualTo: userId)
        .get()
        .then((value) => value.docs.length == 1);
  }

  Future registrationPlayer({required Player player}) {
    // Регистрация игрока
    return playersCollection
        .add(player.toMap())
        .then((response) => player.docId = response.id);
  }

  Future registrationTeam({required Team team}) {
    // Регистрация команды
    return teamsCollection
        .add(team.toMap())
        .then((response) => team.docId = response.id);
  }

  Future<bool> checkTeamName({required String name}) {
    // Проверка названия команды на уникальность
    return teamsCollection
        .where('Title', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }

  void updatePlayer({required Player player}) {
    // Обновление информации об игроке
    playersCollection.doc(player.docId).update(
          player.toMap(),
        );
  }

  void updateTeam({required Team team}) {
    // Обновление информации о команде
    teamsCollection.doc(team.docId).update(
          team.toMap(),
        );
  }

  void addTour({required Tour tour}) {
    // Добавление тура на сервер
    scheduleCollection
        .add(tour.toMap())
        .then((reaponse) => tour.docId = reaponse.id);
  }

  void updateTour({required Tour tour}) {
    // Обновление тура на сервере
    scheduleCollection.doc(tour.docId).update(
          tour.toMap(),
        );
  }

  // Future<bool> existForecast({@required String stage}){ // Проверка прогноза на сервере
  // forecastsCollection.where('Tour')
  //   return true;
  // }

//! Выше используется и не требует изменений

  Future<bool> checkForecast({
    required String uid,
    required String stage,
  }) {
    return forecastsCollection
        .where(
          'UserId',
          isEqualTo: uid,
        )
        .where('Tour', isEqualTo: stage)
        .get()
        .then((QuerySnapshot response) => response.docs.length == 1);
  }

  Future makeForecast({required Forecast forecast}) async {
    // Создание прогноза
    return forecastsCollection
        .add(forecast.toMap())
        .then((response) => forecast.docId = response.id);
  }

  Future<Forecast> getForecast({
    required String uid,
    required String tour,
  }) async {
    // Получение прогноза указанного пользователя на указанный тур
    Query query = forecastsCollection
        .where('UserId', isEqualTo: uid)
        .where('Tour', isEqualTo: tour);
    return query.get().then(
          (QuerySnapshot value) => value.docs
              .map(
                (DocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data()!,
                  docId: doc.id,
                ),
              )
              .first,
        );
  }

  Future<List<Forecast>> getForecasts({required String tour}) async {
    // Получение всех прогноз на указанный тур
    Query query = forecastsCollection.where('Tour', isEqualTo: tour);
    return query.get().then(
          (QuerySnapshot value) => value.docs
              .map(
                (DocumentSnapshot doc) => Forecast.fromJson(
                  json: doc.data()!,
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

//! Использовать для обновления результатов с сервера
  Future<List<Match>> getResults({required String tour}) {
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

//! Обновление результатов на сервера
  void updateResults({required Tour tour}) {
    // Обновление результатов матчей конкретного тура
    scheduleCollection.doc(tour.docId).update(
          tour.toMap(),
        );
  }
}
