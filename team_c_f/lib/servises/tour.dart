import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/meets.dart';

class TourService {
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  Future<bool> existsMeets({required int stage}) async {
    DocumentReference doc = await _meetsCollection.add({'Test': 'test'});
    QuerySnapshot snapshot = await _meetsCollection.get();
    if (snapshot.docs.length != 1) {
      _meetsCollection.doc(doc.id).delete();
      return (await _meetsCollection.where('Round', isEqualTo: stage).get())
              .docs
              .length ==
          1;
    } else {
      _meetsCollection.doc(doc.id).delete();
      return false;
    }
  }

  Future<MeetsData?> getMeets({required int stage}) async {
    QuerySnapshot response =
        await _meetsCollection.where('Round', isEqualTo: stage).get();
    return response.docs.length != 0
        ? MeetsData.fromMap(
            data: response.docs.single.data(),
            uid: response.docs.single.id,
          )
        : null;
  }
}
