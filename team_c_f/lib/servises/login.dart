import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService {
  final CollectionReference _playersCollection =
      FirebaseFirestore.instance.collection('players');

  Future<bool> existPlayer({required String uid}) {
    return _playersCollection
        .where(
          'UserId',
          isEqualTo: uid,
        )
        .get()
        .then((QuerySnapshot response) =>
            response.docs.isNotEmpty);
  }
}
