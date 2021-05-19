import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/currenttour.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/forecast.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';
import 'package:team_c_f/models/tour.dart';

class DataService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _teamsCollection =
      FirebaseFirestore.instance.collection('teams');
  final CollectionReference _currentTourCollection =
      FirebaseFirestore.instance.collection('currentTour');
  final CollectionReference _toursCollection =
      FirebaseFirestore.instance.collection('schedule');
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');
  final CollectionReference _forecastsCollection =
      FirebaseFirestore.instance.collection('forecasts');

  Future<bool> initData() async {
    Data.currentTour = await getCurrentTour();
    Data.players = await getPlayers();
    Data.teams = await getTeams();
    Data.tours = await getTours();
    Data.meets = await getMeets();
    Data.names = await getUidLeftForecast();
    return true;
  }

  Future<List<String>> getUidLeftForecast() {
    int round = Data.currentTour.round;
    if (Data.meets.where((element) => element.round == round).single.started)
      round++;
    return _forecastsCollection.where('Round', isEqualTo: round).get().then(
          (QuerySnapshot response) => response.docs
              .map((QueryDocumentSnapshot doc) =>
                  ForecastData.fromMap(data: doc.data(), docId: doc.id).uid)
              .toList(),
        );
  }

  Future<CurrentTourData> getCurrentTour() {
    return _currentTourCollection.get().then(
          (QuerySnapshot response) => CurrentTourData.fromMap(
            data: response.docs.single.data(),
            docId: response.docs.single.id,
          ),
        );
  }

  Future<List<PlayerData>> getPlayers() {
    return _playersCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => PlayerData.fromMap(
                  data: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<List<TeamData>> getTeams() {
    return _teamsCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => TeamData.fromMap(
                  data: doc.data(),
                  docId: doc.id,
                ),
              )
              .toList(),
        );
  }

  Future<List<TourData>> getTours() {
    return _toursCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => TourData.fromMap(
                  data: doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<List<MeetsData>> getMeets() {
    return _meetsCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) =>
                    MeetsData.fromMap(data: doc.data(), docId: doc.id),
              )
              .toList(),
        );
  }
}
