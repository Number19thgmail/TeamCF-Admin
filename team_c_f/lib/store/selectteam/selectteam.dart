import 'package:mobx/mobx.dart';
import 'package:team_c_f/servises/login.dart';
part 'selectteam.g.dart';

class SelectTeam = _SelectTeamBase with _$SelectTeam;

abstract class _SelectTeamBase with Store {
  
  @observable
  String teamName = 'No team';

  @action
  void changeTeam(String text){
    teamName = text.trim();
  }

  @observable
  String lastTeamName = '';

  @computed
  Future<bool> get availableTeamName async { return await LoginService().checkTeamName(name: teamName);}

  @observable
  bool capitan = false;

  @action
  void changeCapitan(bool? value){
    capitan = value!;
    lastTeamName = teamName;
  }
}