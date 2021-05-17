import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/tour.dart';

class CreateScheduleService {
  final CollectionReference _scheduleCollection =
      FirebaseFirestore.instance.collection('schedule');
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  void create() {
    Data.tours.forEach(
      (TourData tour) {
        _scheduleCollection.add(
          tour.toMap(),
        );
      },
    );
    Data.meets.forEach(
      (MeetsData meets) {
        _meetsCollection.add(
          meets.toMap(),
        );
      },
    );
  }
}
