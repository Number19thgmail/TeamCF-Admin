import 'package:team_c_f/models/meet.dart';

class MeetModel {
  late List<String> team = [];
  late List<int> score = [];
  late String info;
  late bool started;

  MeetModel({required MeetData meet}) {
    team = meet.team;
    score = meet.score;
    info = meet.date.toString();
    started = meet.started;
  }
}
