import 'package:flutter/material.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/element/notconfirmedplayer.dart';
import 'package:team_c_f/element/team.dart';

class TeamView extends StatefulWidget {
  // Класс, отображающий информацию о команде участника
  const TeamView({Key key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  @override
  Widget build(BuildContext context) {
    Player me = context // Поиск текущего участника среди всех участников
        .read<Tournament>()
        .allPlayers
        .where(
          (player) => player.itIsMe(uid: context.read<Account>().userId),
        )
        .first;
    Team myTeam = context // Поиск команды текущего игрока среди всех команд
        .read<Tournament>()
        .allTeams
        .where((team) => team.title == me.team)
        .first;
    Player myCapitan = context // Поиск капитана текущей команды
        .read<Tournament>()
        .allPlayers
        .where((player) => player.team == me.team && player.capitan)
        .first;
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              // Показывает место в таблице бомбардиров
              backgroundColor: Colors.blue[100],
              child: Text(me.position.toString()),
            ),
            title: Row(
              children: [
                Text(me.name), // Показывает имя участника
                // InkWell(
                //   child: Icon(Icons.edit),
                //   onTap: (){},
                // ),
              ],
            ),
            subtitle: Row(
              children: [
                // Показываем статус игрока, подтвержден ли он капитаном команды
                Icon(me.confirmed ? Icons.done : Icons.not_interested,
                    color: me.confirmed ? Colors.green : Colors.red),
                Text(me.team),
              ],
            ),
            trailing: InkWell(
              // Кнопка выхода из аккаунта
              onTap: () {
                context.read<Account>().changeSignIn();
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.exit_to_app),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (me
              .capitan) // Отображение для капитана списка игроков, которые зарегистрировались, но ещё не получили подтверждение в его команде
            ...context
                .read<Tournament>()
                .allPlayers
                .where((player) =>
                    (!player.confirmed && player.team == myTeam.title))
                .map(
                  (p) => PlayerToComfirm(player: p),
                ),
          SizedBox(height: 20),
          ShowTeam(
            // Показ информации о моей команде
            team: myTeam,
          ),
        ],
      ),
    );
  }
}
