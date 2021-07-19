import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/forecast.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class TourState {
  final int round;
  late MeetsModel meets;
  late TourModel tour;
  late bool size = false;

  TourState({required this.round, required String uid}) {
    tour = TourModel(
        tour: Data.tours.where((TourData t) => t.round == round).single);
    meets = MeetsModel(
        meet: Data.meets.where((MeetsData m) => m.round == round).single);
    // TourService()
    //     .getForecast(uid: uid, round: round)
    //     .then((ForecastData? response) => forecast = response);
  }

  TourState copyWith({
    int? round,
    MeetsData? meetsData,
    TourModel? tour,
    bool? size,
  }) {
    MeetsModel? meets = meetsData != null ? MeetsModel(meet: meetsData) : null;
    return TourState.all(
      round: round ?? this.round,
      meets: meets ?? this.meets,
      tour: tour ?? this.tour,
      size: size ?? this.size,
    );
  }

  TourState.all({
    required this.round,
    required this.meets,
    required this.tour,
    required this.size,
  });
}
