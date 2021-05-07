import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';

class MyTeamService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _teamsCollection =
      FirebaseFirestore.instance.collection('teams');

  void updatePlayer({required PlayerData player}) {
    _playersCollection.doc(player.docId).update(player.toMap());
  }

  void updateTeam({required TeamData team}) {
    _teamsCollection.doc(team.docId).update(team.toMap());
  }
}
