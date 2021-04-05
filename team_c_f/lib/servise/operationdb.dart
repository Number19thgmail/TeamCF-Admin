import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future makeForecast({Forecast forecast}) {
    return forecastsCollection
        .add(forecast.toMap())
        .then((response) => forecast.docId = response.id);
  }

  Future<List<Player>> getAllPlayers() {
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

  Future<Forecast> getForecast({String uid, String tour}) {
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

  Future<List<Forecast>> getForecasts({String tour}) {
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
    return teamsCollection
        .add(team.toMap())
        .then((response) => team.docId = response.id);
  }

  Future<bool> userExists({String userId}) {
    return playersCollection
        .where('UserId', isEqualTo: userId)
        .get()
        .then((value) => value.docs.length == 1);
  }

  Future<bool> checkTeamName({String name}) {
    return teamsCollection
        .where('Title', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }

  Future registrationPlayer({Player player}) {
    return playersCollection.add(player.toMap());
  }

  Future<List<String>> getAllTeamNames() {
    return teamsCollection.get().then((response) {
      return response.docs
          .map((element) =>
              Team.fromJson(json: element.data(), docId: element.id).title)
          .toList();
    });
  }

  Future<List<Team>> getAllTeam() {
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
    return currentCollection.get().then(
          (response) => CurrentTour.fromJson(
            json: response.docs.first.data(),
          ),
        );
  }

  Future<List<Tour>> getAllTour() {
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

  Future<List<Match>> getResults({String tour}) {
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

  void updateResults({Tour tour}) {
    scheduleCollection.doc(tour.docId).update(
          tour.toMap(),
        );
  }

  // void updateCurrentTour({String tour}) {
  //   scheduleCollection.doc(tour.docId).update(
  //         tour.toMap(),
  //       );
  // }

  // final CollectionReference _mealCollection =
  //     FirebaseFirestore.instance.collection('meals');

  // Future addMeal({OneMeal meal}) {
  //   return _mealCollection
  //       .add(
  //         meal.toMap(),
  //       )
  //       .then((value) => meal.docId = value.id);
  // }

  // Stream<List<OneMeal>> getMeal() {
  //   Query query = _mealCollection.where(
  //     'time',
  //     isGreaterThan: DateTime.now().add(Duration(days: -2)).toString(),
  //   );
  //   return query
  //       .snapshots(includeMetadataChanges: true)
  //       .map((QuerySnapshot data) => data.docs
  //           .map(
  //             (DocumentSnapshot doc) =>
  //                 OneMeal.fromJson(data: doc.data(), docId: doc.id),
  //           )
  //           .toList());
  // }

  // void deleteMeal(String id){
  //   _mealCollection.doc(id).delete();
  // }
}
