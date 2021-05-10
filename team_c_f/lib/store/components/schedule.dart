import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/store/components/tour.dart';

class ScheduleState {
  late bool enableSchedule;
  late List<TourModel> tours = [];

  ScheduleState() {
    tours = [...Data.tours.map((TourData tour) => TourModel(tour: tour))];
    enableSchedule = tours.isNotEmpty;
  }

  ScheduleState copyWith({
    List<TourModel>? tours,
  }) =>
      ScheduleState.all(tours: tours ?? this.tours);

  ScheduleState.all({required this.tours});
}
