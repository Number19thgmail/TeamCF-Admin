import 'package:mobx/mobx.dart';
import 'package:team_c_f/data/team.dart';
part 'team.g.dart';

class Team extends _TeamBase with _$Team {
  Team({required TeamData team}) : super(team: team);
}

abstract class _TeamBase with Store {
  _TeamBase({required this.team});

  @observable
  TeamData? team;
}
