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

  void registrateTeam({required Team team}) {
    // регистрация команды
    _teamsCollection.add(team.toMap());
  }

  Future<String?> existPlayer({required String uid}) {
    return _playersCollection
        .where(
          'UserId',
          isEqualTo: uid,
        )
        .get()
        .then((QuerySnapshot response) => response.docs.isNotEmpty ? response.docs.single.id : null);
  }

  void registratePlayer({required Player player}) {
    // регистрация игрока
    _playersCollection.add(player.toMap());
  }

  void updatePlayer({required Player player}) {
    // обновление игрока (добавление команды)
  }
}
