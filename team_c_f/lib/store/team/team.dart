import 'package:mobx/mobx.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/models/team.dart';
part 'team.g.dart';

class Team extends _TeamBase with _$Team {
  Team({required TeamData team}) : super(team: team);
}

abstract class _TeamBase with Store {
  _TeamBase({required this.team}) {
    team.players.forEach(
      (String uid) {
        players.add(Data.players.where((PlayerData p) => p.uid == uid).single);
      },
    );
  }

  @observable
  List<PlayerData> players = [];

  @observable
  late TeamData team;

  @action
  void addWin(){
    team.win++;
  }
}
