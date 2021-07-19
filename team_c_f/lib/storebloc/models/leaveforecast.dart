import 'package:team_c_f/models/meet.dart';
import 'package:intl/intl.dart';

class LeaveForecastModel {
  late String date;
  late int home;
  late int away;
  late List<String> teams = [];

  LeaveForecastModel({required MeetData meet, List<int>? goal}) {
    date = DateFormat('dd.MM')
        .format(DateFormat('yyyy-MM-dd HH:mm').parse(meet.date));
    home = goal != null ? goal[0] : meet.score.first;
    away = goal != null ? goal[1] : meet.score.last;
    teams.addAll([...meet.team]);
  }
}
