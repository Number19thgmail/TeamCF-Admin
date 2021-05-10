import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';

class MyTeamService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _teamsCollection =
      FirebaseFirestore.instance.collection('teams');

  void confirmedPlayer(bool confirmed, String uid) {
    PlayerData player =
        Data.players.where((PlayerData p) => p.uid == uid).single;
    TeamData team =
        Data.teams.where((TeamData t) => t.name == player.team).single;
    if (confirmed) {
      team.players.add(uid);
      _teamsCollection.doc(team.docId).update(team.toMap());
    } else {
      player.team = null;
      _playersCollection.doc(player.docId).update(player.toMap());
      if (team.players.any((String playerUid) => playerUid == uid)) {
        team.players.removeWhere((String playerId) => playerId == uid);
        _teamsCollection.doc(team.docId).update(team.toMap());
      }
    }
  }
}
