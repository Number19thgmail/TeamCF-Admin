import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/meets.dart';

class MeetsModel {
  late int round;
  late String deadline;
  late List<MeetData> meets;
  late bool started;

  MeetsModel({required MeetsData meet}) {
    started = meet.started;
    deadline = meet.deadline;
    meets = meet.meets;
    round = meet.round;
  }
}
