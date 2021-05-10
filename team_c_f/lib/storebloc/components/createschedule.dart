import 'dart:core';
import 'package:team_c_f/data/data.dart';

class CreateScheduleState {
  late int circle;
  late int registTeam;
  late int fullTeam;
  int get matches => (fullTeam / 2).floor();
  int get tours =>  circle * (fullTeam.isEven ? fullTeam - 1 : fullTeam);

  CreateScheduleState() {
    circle = 1;
    registTeam = Data.teams.length;
    fullTeam = 16;
        //Data.teams.where((TeamData team) => team.players.length == 3).length;
  }

  CreateScheduleState copyWith({
    int? circle,
    int? registTeam,
    int? fullTeam,
  }) =>
      CreateScheduleState.all(
        circle: circle ?? this.circle,
        registTeam: registTeam ?? this.registTeam,
        fullTeam: fullTeam ?? this.fullTeam,
      );

  CreateScheduleState.all({
    required this.circle,
    required this.registTeam,
    required this.fullTeam,
  });
}
