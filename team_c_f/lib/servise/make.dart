import 'package:team_c_f/data/shortmatch.dart';
import 'package:collection/collection.dart';
import 'package:team_c_f/view/day.dart';
import 'package:team_c_f/view/tournament.dart';

List<TournamentView> makeTournaments({List<ShortMatch> matches}) {
  Map<String, List<ShortMatch>> gr =
      groupBy<ShortMatch, String>(matches, (obj) => obj.tournament);
  List<TournamentView> list = [];
  gr.forEach((key, value) {
    list.add(TournamentView(
      tournament: key,
      matches: value,
    ));
  });
  return list;
}

List<DayView> makeDays(List<ShortMatch> data) {
  Map<String, List<ShortMatch>> gr =
      groupBy<ShortMatch, String>(data, (obj) => obj.date);
  List<DayView> list = [];
  gr.forEach((key, value) {
    list.add(DayView(
      date: key,
      matches: value,
    ));
  });
  return list;
}
