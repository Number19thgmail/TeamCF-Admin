import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/team.dart';
import 'package:team_c_f/models/tour.dart';

class TourModel {
  late String name;
  late List<List<Map<String, int?>>> result;
  late List<List<String>> matches;
  late List<List<int?>> goals;

  TourModel({required TourData tour}) {
    name = tour.name ?? tour.round.toString();
    int round = tour.round - 1;
    result = tour.team.map(
      (List<String> pair) {
        return pair.map(
          (String team) {
            TeamData teamData =
                Data.teams.where((TeamData t) => t.name == team).single;
            return {
              team: teamData.goal.length > round ? teamData.goal[round] : null
            };
          },
        ).toList();
      },
    ).toList();
  }
}
