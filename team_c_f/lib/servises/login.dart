import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/info.dart';

class LoginService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');
  final CollectionReference _infoCollection =
      FirebaseFirestore.instance.collection('information');

  Future<bool> existPlayer({required String uid}) {
    return _playersCollection
        .where(
          'UserId',
          isEqualTo: uid,
        )
        .get()
        .then((QuerySnapshot response) => response.docs.isNotEmpty);
  }

  Future<InfoData> getInfo() {
    return _infoCollection.get().then(
          (QuerySnapshot response) => InfoData.fromMap(
            data: response.docs.single.data(),
          ),
        );
  }
}
