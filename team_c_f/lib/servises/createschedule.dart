import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';

class CreateScheduleService {
  final CollectionReference _scheduleCollection =
      FirebaseFirestore.instance.collection('schedule');

  void create() {
    Map<String, dynamic> a = Data.tours.first.toMap();
    Data.tours.forEach(
      (TourData tour) {
        _scheduleCollection.add(
          tour.toMap(),
        );
      },
    );
  }
}
