import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/tour.dart';

class ScheduleService {
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  Future<MeetData> getMeets({required String stage}) {
    return _meetsCollection.where('Round', isEqualTo: stage).get().then(
          (QuerySnapshot response) => MeetData.fromMap(
            data: response.docs.single.data(),
          ),
        );
  }
}
