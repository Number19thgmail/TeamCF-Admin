import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';
import 'package:team_c_f/store/components/team.dart';
import 'package:team_c_f/store/components/unconfirmedplayer.dart';

class MyTeamState {
  final String uid;
  late String position;
  late String name;
  late String team = 'Нет команды';
  TeamModel? teamData;
  late bool confirmed;
  late bool capitan;
  List<UnconfirmedPlayerModel> unconfirm = [];
  late String selectId;

  MyTeamState({required this.uid}) {
    PlayerData p = Data.players
        .where((PlayerData playerData) => playerData.uid == uid)
        .single;
    position = p.prevPosition.toString();
    name = p.name;
    if (p.team != null) {
      team = p.team!;
      TeamData t =
          Data.teams.where((TeamData teamData) => teamData.name == team).single;
      teamData = TeamModel(team: t);
      confirmed = t.players.any((String uid) => uid == this.uid);
      capitan = t.uidCapitan == uid;

      if (capitan) {
        unconfirm = [
          ...Data.players
              .where((PlayerData playerData) => playerData.team == team)
              .where((PlayerData playerData) =>
                  t.players.every((String uid) => uid != playerData.uid))
              .map((PlayerData playerData) =>
                  UnconfirmedPlayerModel(uid: playerData.uid))
        ];
      }
    } else {
      capitan = false;
      confirmed = false;
    }
  }

  MyTeamState copyWith({
    String? position,
    bool? confirmed,
    String? team,
    TeamModel? teamData,
    bool? capitan,
    List<UnconfirmedPlayerModel>? unconfirm,
  }) =>
      MyTeamState.all(
        uid: uid,
        position: position ?? this.position,
        confirmed: confirmed ?? this.confirmed,
        name: name,
        team: team == null
            ? this.team
            : team == ''
                ? 'Нет команды'
                : team,
        teamData: teamData ?? this.teamData,
        capitan: capitan ?? this.capitan,
        unconfirm: unconfirm ?? this.unconfirm,
      );

  MyTeamState.all({
    required this.uid,
    required this.position,
    required this.confirmed,
    required this.name,
    required this.team,
    required this.teamData,
    required this.capitan,
    required this.unconfirm,
  });
}
