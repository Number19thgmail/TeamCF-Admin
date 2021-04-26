import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService {
  final CollectionReference playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference teamsCollection =
      FirebaseFirestore.instance.collection('teams');

  Future<bool> checkTeamName({required String name}) {
    // Проверка названия команды на уникальность
    return teamsCollection
        .where('Title', isEqualTo: name)
        .get()
        .then((response) => response.docs.length == 0);
  }
}
