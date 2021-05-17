import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meets.dart';

class SelectMeetsService {
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  void cteateMeet({required MeetsData meet}) {
    MeetsData current = Data.meets.where((element) => element.round == meet.round).single;
    meet.uid = current.uid;
    Data.meets.remove(current);
    Data.meets.add(meet);
    _meetsCollection.doc(meet.uid).update(meet.toMap());
  }
}
