import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/servises/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class TourState {
  final int round;
  MeetModel? meets;
  late TourModel tour;

  TourState({required this.round}) {
    tour = TourModel(
        tour: Data.tours.where((TourData t) => t.round == round).single);
    TourService()
        .getMeets(stage: round)
        .then((MeetData value) => meets = MeetModel(meet: value));
  }

  Future<TourState> copyWith({
    int? round,
    MeetModel? meets,
    TourModel? tour,
  }) async {
    if (round != null) {
      if (await TourService().existsMeets(stage: round)) {
        meets = MeetModel(
          meet: await TourService().getMeets(stage: round),
        );
      }
    }
    return TourState.all(
      round: round ?? this.round,
      meets: meets ?? this.meets,
      tour: tour ?? this.tour,
    );
  }

  TourState.all({
    required this.round,
    required this.meets,
    required this.tour,
  });
}
