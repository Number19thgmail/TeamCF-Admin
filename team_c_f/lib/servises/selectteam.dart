import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/player.dart';

class SelectTeamService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _teamsCollection =
      FirebaseFirestore.instance.collection('teams');

  Future<bool> checkTeamName({required String name}) {
    // Проверка названия команды на уникальность
    return _teamsCollection
        .where('Name', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }

  Future registrateTeam({required Team team}) async {
    // регистрация команды
    await _teamsCollection.add(team.toMap());
  }

  Future<String?> existPlayer({required String uid}) {
    return _playersCollection
        .where(
          'UserId',
          isEqualTo: uid,
        )
        .get()
        .then((QuerySnapshot response) =>
            response.docs.isNotEmpty ? response.docs.single.id : null);
  }

  Future<List<String>?> allTeamNames() {
    return _teamsCollection.get().then(
          (QuerySnapshot response) => response.docs
              .where((QueryDocumentSnapshot doc) =>
                  Team.fromMap(doc.data()).players.length < 3)
              .map(
                (QueryDocumentSnapshot doc) => Team.fromMap(doc.data()).name,
              )
              .toList(),
        );
  }

  Future<bool> registratePlayer({required Player player}) async {
    // регистрация игрока
    await _playersCollection.add(player.toMap());
    return true;
  }

  Future<bool> updatePlayer({required Player player}) async {
    // обновление игрока (добавление команды)
    await _playersCollection.doc(player.docId).update(
          player.toMap(),
        );
    return true;
  }
}
