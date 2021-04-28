import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tour.dart';

class DataService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _teamsCollection =
      FirebaseFirestore.instance.collection('teams');
  final CollectionReference _currentTourCollection =
      FirebaseFirestore.instance.collection('currentTour');
  final CollectionReference _toursCollection =
      FirebaseFirestore.instance.collection('tours');

  void initData() {
    getCurrentTour()
        .then((CurrentTour currentTour) => Data.currentTour = currentTour);
    getPlayers().then((List<Player> players) => Data.players = players);
    getTeams().then((List<Team> teams) => Data.teams = teams);
    getTours().then((List<Tour> tours) => Data.tours = tours);
  }

  Future<CurrentTour> getCurrentTour() {
    return _currentTourCollection.get().then(
          (QuerySnapshot response) => CurrentTour.fromMap(
            data: response.docs.single.data(),
          ),
        );
  }

  Future<List<Player>> getPlayers() {
    return _playersCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => Player.fromMap(
                  data: doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<List<Team>> getTeams() {
    return _teamsCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => Team.fromMap(
                  data: doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<List<Tour>> getTours() {
    return _toursCollection.get().then(
          (QuerySnapshot response) => response.docs
              .map(
                (QueryDocumentSnapshot doc) => Tour.fromMap(
                  data: doc.data(),
                ),
              )
              .toList(),
        );
  }
}
