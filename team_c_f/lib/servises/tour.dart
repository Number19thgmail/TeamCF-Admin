import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/meet.dart';

class TourService {
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  Future<bool> existsMeets({required int stage}) async {
    DocumentReference doc = await _meetsCollection.add({'Test': 'test'});
    QuerySnapshot snapshot = await _meetsCollection.get();
    if (snapshot.docs.length != 1) {
      _meetsCollection.doc(doc.id).delete();
      return _meetsCollection
          .where('Round', isEqualTo: stage)
          .get()
          .then((QuerySnapshot response) => response.docs.length == 1);
    } else {
      _meetsCollection.doc(doc.id).delete();
      return false;
    }
  }

  Future<MeetData> getMeets({required int stage}) {
    return _meetsCollection.where('Round', isEqualTo: stage).get().then(
          (QuerySnapshot response) => MeetData.fromMap(
            data: response.docs.single.data(),
          ),
        );
  }
}
