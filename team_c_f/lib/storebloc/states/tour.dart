import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class TourState {
  final int round;
  late MeetsModel meets;
  late TourModel tour;

  TourState({required this.round}) {
    tour = TourModel(
        tour: Data.tours.where((TourData t) => t.round == round).single);
    meets = MeetsModel(
        meet: Data.meets.where((MeetsData m) => m.round == round).single);
  }

  TourState copyWith({
    int? round,
    MeetsData? meetsData,
    TourModel? tour,
  }) {
    MeetsModel? meets;
    if (meetsData != null) meets = MeetsModel(meet: meetsData);
    // if (round != null)
    //   meets = MeetsModel(
    //       meet: Data.meets.where((MeetsData m) => m.round == round).single);
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
