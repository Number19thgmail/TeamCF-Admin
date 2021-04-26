import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:team_c_f/servises/selectteam.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/player.dart';
part 'selectteam.g.dart';

class SelectTeam = _SelectTeamBase with _$SelectTeam;

abstract class _SelectTeamBase with Store {
  //_SelectTeamBase({required this.uid, required this.userName});
  String? uid;
  String? userName;

  @observable
  String teamName = 'No team';

  @action
  void changeTeam(String text) {
    teamName = text.trim();
    SelectTeamService().checkTeamName(name: teamName).then((bool enable) {
      enableIcon = Icon(
        enable ? Icons.done : Icons.cancel,
        color: enable ? Colors.green : Colors.red,
      );
      enableName = enable;
    });
  }

  @observable
  bool enableName = false;

  @observable
  String lastTeamName = '';

  @observable
  bool capitan = false;

  @action
  void changeCapitan(bool? value) {
    capitan = value!;
    lastTeamName = teamName;
  }

  @observable
  Icon enableIcon = Icon(
    Icons.done,
    color: Colors.green,
  );

  @action
  void registrateTeam() {// Регистрация команды
    SelectTeamService().registrateTeam(
      team: Team(
        name: teamName,
        uidCapitan: uid!,
      ),
    );
    //SelectTeamService().
    SelectTeamService().registratePlayer( 
      player: Player(
        name: userName!,
        uid: uid!,
      ),
    );
  }
}
