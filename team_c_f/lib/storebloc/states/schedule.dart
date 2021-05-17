import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class ScheduleState {
  bool get enableSchedule => Data.tours.isNotEmpty;
  late bool tourSelected = false;
  late List<TourModel> tours = [];
  late int? round;
  late TourBloc? tourBloc;

  ScheduleState() {
    tours = [...Data.tours.map((TourData tour) => TourModel(tour: tour))];
  }

  ScheduleState copyWith({
    List<TourModel>? tours,
    //MeetsModel? meets,
    int? nameTour,
    bool? tourSelected,
    int? round,
    TourBloc? tourBloc,
  }) {
    return ScheduleState.all(
      tours: tours ?? this.tours,
      tourSelected: tourSelected ?? this.tourSelected,
      round: round ?? this.round,
      tourBloc: tourBloc ?? tourBloc,
    );
  }

  ScheduleState.all({
    required this.tours,
    required this.tourSelected,
    required this.round,
    required this.tourBloc,
  });
}
