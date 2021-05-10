import 'package:team_c_f/models/team.dart';

class TeamModel{
  final TeamData team;
  late String teamName;
  late String position;
  late int points;

  TeamModel({required this.team}){
    teamName = team.name;
    position = team.prevPosition.toString();
    points = team.points;
  }
}