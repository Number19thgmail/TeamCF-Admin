import 'package:mobx/mobx.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/store/team/team.dart';
part 'myteam.g.dart';

class MyTeam extends _MyTeamBase with _$MyTeam {
  MyTeam({required PlayerData player}) : super(me: player);
}

abstract class _MyTeamBase with Store {
  _MyTeamBase({required this.me}) {
    team = Team(
        team: Data.teams.where((element) => element.name == me.team).single);
    if (me.uid == team!.team.uidCapitan) {
      List<PlayerData> inTeam = [];
      inTeam.addAll(
        Data.players.where((PlayerData p) => p.team == team!.team.name),
      );
      unconfirmPlayer.addAll(
        inTeam.where(
          (PlayerData p) =>
              team!.team.players.every((String uid) => uid != p.uid),
        ),
      );
    }
  }

  @observable
  List<PlayerData> unconfirmPlayer = [];

  @action
  void confirm({required String uid, required bool confirm}) {
    unconfirmPlayer.removeWhere((PlayerData p) => p.uid == uid);
    if (confirm) team!.team.players.add(uid);
  }

  @observable
  PlayerData me;

  @observable
  Team? team;
}
