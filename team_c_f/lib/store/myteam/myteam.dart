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
  }

  @observable
  PlayerData me;

  @observable
  Team? team;
}
