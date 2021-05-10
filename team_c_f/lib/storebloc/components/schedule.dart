import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';

class ScheduleState {
  bool get enableSchedule => Data.tours.isNotEmpty;
  late List<TourModel> tours = [];
  late MeetModel meets;

  ScheduleState() {
    tours = [...Data.tours.map((TourData tour) => TourModel(tour: tour))];
    Data.getMeets(Data.currentTour.round).then(
      (MeetData meet) => meets = MeetModel(meet: meet),
    );
  }

  ScheduleState copyWith({
    List<TourModel>? tours,
    MeetModel? meets,
  }) =>
      ScheduleState.all(
        tours: tours ?? this.tours,
        meets: meets ?? this.meets,
      );

  ScheduleState.all({
    required this.tours,
    required this.meets,
  });
}
