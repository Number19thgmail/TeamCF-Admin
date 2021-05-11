import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';

class ScheduleState {
  bool get enableSchedule => Data.tours.isNotEmpty;
  late bool tourSelected = false;
  late String nameTour;
  late List<TourModel> tours = [];
  MeetModel? meets;

  ScheduleState() {
    tours = [...Data.tours.map((TourData tour) => TourModel(tour: tour))];
    Data.getMeets(Data.currentTour.round).then(
      (MeetData meet) => meets = MeetModel(meet: meet),
    );
  }

  ScheduleState copyWith({
    List<TourModel>? tours,
    MeetModel? meets,
    String? nameTour,
    bool? tourSelected,
  }) =>
      ScheduleState.all(
        tours: tours ?? this.tours,
        meets: meets ?? this.meets,
        nameTour: nameTour ?? this.nameTour,
        tourSelected: tourSelected ?? this.tourSelected,
      );

  ScheduleState.all({
    required this.tours,
    this.meets,
    required this.nameTour,
    required this.tourSelected,
  });
}
