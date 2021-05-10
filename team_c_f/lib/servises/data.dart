import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/currenttour.dart';
import 'package:team_c_f/data/data.dart';
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
      FirebaseFirestore.instance.collection('tours');
  // final CollectionReference _forecastsCollection =
  //     FirebaseFirestore.instance.collection('forecasts');

  Future<bool> initData() async {
    Data.currentTour = await getCurrentTour();
    Data.players = await getPlayers();
    Data.teams = await getTeams();
    Data.tours = await getTours();
    return true;
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
}
