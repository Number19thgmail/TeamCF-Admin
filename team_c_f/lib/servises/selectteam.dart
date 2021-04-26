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
        .where('Name2', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }

  void registrateTeam({required Team team}){
    // регистрация команды
    _teamsCollection.add(team.toMap());
  }

  // Future<bool> existPlayer({required String uid}){
  //   _playersCollection.where(field)
  // }

  void registratePlayer({required Player player}){
    // регистрация игрока
    _playersCollection.add(player.toMap());
  }

  void updatePlayer({required Player player}){

    // обновление игрока (добавление команды)
  }
}