import 'package:mobx/mobx.dart';
import 'package:team_c_f/servises/selectteam.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/player.dart';
part 'selectteam.g.dart';

class SelectTeam = _SelectTeamBase with _$SelectTeam;

abstract class _SelectTeamBase with Store {
  _SelectTeamBase() {
    getAllTeamNames().then(
      (List<String>? allNames) =>
          allTeamNames = allNames == null ? [] : [...allNames],
    );
  }
  String regButtonText = 'Зарегистрироваться';
  String uId = '';
  String uName = '';

  @observable
  String teamName = '';

  @action
  void changeTeam(String text) {
    teamName = text.trim();
    SelectTeamService().checkTeamName(name: teamName).then((bool enable) {
      enableName = enable;
    });
    editNameComplite(text: text);
  }

  @observable
  bool enableName = false;

  @observable
  String lastTeamName = '';

  void editNameComplite({required String text}) {
    lastTeamName = text;
  }

  @observable
  bool capitan = false;

  @action
  void changeCapitan(bool? value) {
    capitan = value!;
    lastTeamName = teamName;
  }

  @observable
  String? selectedTeam;

  @action
  void selestTeam(String? name) {
    selectedTeam = name;
  }

  @observable
  List<String> allTeamNames = [];

  @action
  Future<bool> assertTeam() async {
    // Выбор команды
    String? docId = await SelectTeamService().existPlayer(uid: uId);

    PlayerData p = PlayerData(
      team: capitan ? teamName : selectedTeam,
      name: uName,
      uid: uId,
      docId: docId,
    );
    return docId == null
        ? await SelectTeamService().registratePlayer(
            player: p,
          )
        : await SelectTeamService().updatePlayer(
            player: p,
          );
  }

  @action
  Future registrateTeam() async {
    // Регистрация команды
    await SelectTeamService().registrateTeam(
      team: TeamData(
        name: teamName,
        uidCapitan: uId,
      ),
    );
    await assertTeam();
  }

  Future<List<String>?> getAllTeamNames() {
    return SelectTeamService().allTeamNames();
  }
}
