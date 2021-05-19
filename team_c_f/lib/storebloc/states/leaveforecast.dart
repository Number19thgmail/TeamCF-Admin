import 'package:team_c_f/models/forecast.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/storebloc/models/leaveforecast.dart';

class LeaveForecastState {
  late int round;
  late List<LeaveForecastModel> meets = [];

  LeaveForecastState({
    required MeetsData meetsData,
    ForecastData? forecast,
  }) {
    round = meetsData.round;
    meets.addAll([
      ...meetsData.meets.map(
        (MeetData meet) => LeaveForecastModel(
          meet: meet,
          goal: forecast != null
              ? [
                  forecast.rate[meetsData.meets.indexOf(meet) * 2],
                  forecast.rate[meetsData.meets.indexOf(meet) * 2 + 1]
                ]
              : null,
        ),
      ),
    ]);
  }

  LeaveForecastState copyWith({
    int? round,
    List<LeaveForecastModel>? meets,
  }) =>
      LeaveForecastState.all(
        round: round ?? this.round,
        meets: meets ?? this.meets,
      );

  LeaveForecastState.all({
    required this.round,
    required this.meets,
  });
}
