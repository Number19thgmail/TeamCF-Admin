import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';

class ScheduleState {
  bool get enableSchedule => Data.tours.isNotEmpty;
  late bool tourSelected = false;
  late String nameTour;
  late List<TourModel> tours = [];

  ScheduleState() {
    tours = [...Data.tours.map((TourData tour) => TourModel(tour: tour))];
  }

  ScheduleState copyWith({
    List<TourModel>? tours,
    MeetModel? meets,
    String? nameTour,
    bool? tourSelected,
  }) =>
      ScheduleState.all(
        tours: tours ?? this.tours,
        nameTour: nameTour ?? this.nameTour,
        tourSelected: tourSelected ?? this.tourSelected,
      );

  ScheduleState.all({
    required this.tours,
    required this.nameTour,
    required this.tourSelected,
  });
}
