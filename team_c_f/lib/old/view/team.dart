import 'package:flutter/material.dart';
import 'package:team_c_f/old/data/data.dart';
import 'package:team_c_f/old/data/tournament.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/old/element/notconfirmedplayer.dart';
import 'package:team_c_f/old/element/selectTeam.dart';
import 'package:team_c_f/old/element/team.dart';

class TeamView extends StatefulWidget {
  // Класс, отображающий информацию о команде участника
  const TeamView({Key? key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  bool capitan = false;
  TextEditingController teamController = TextEditingController();
  String? teamSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              // Показывает место в таблице бомбардиров
              backgroundColor: Colors.blue[100],
              child: Text(context.read<Tournament>().me.position.toString()),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context
                    .read<Tournament>()
                    .me
                    .name), // Показывает имя участника
                // InkWell(
                //   child: Icon(Icons.edit),
                //   onTap: (){},
                // ),
              ],
            ),
            subtitle: context.read<Tournament>().me.team.isNotEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Показываем статус игрока, подтвержден ли он капитаном команды
                      Icon(Icons.done,
                          color: context.read<Tournament>().me.confirmed
                              ? Colors.green
                              : Colors.grey),
                      Text(context.read<Tournament>().me.team),
                    ],
                  )
                : SelectTeam(message: 'Подтвердить'),
            trailing: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    context.read<Account>().changeSignIn();
                  }),
            ),
          ),
          SizedBox(height: 20),
          if (context
              .watch<Tournament>()
              .me
              .capitan) // Отображение для капитана списка игроков, которые зарегистрировались, но ещё не получили подтверждение в его команде
            ...context
                .watch<Tournament>()
                .allPlayers
                .where((player) => (!player.confirmed &&
                    player.team == context.read<Tournament>().myTeam!.title))
                .map(
                  (p) => PlayerToConfirm(player: p),
                ),
          SizedBox(height: 20),
          if (context.read<Tournament>().myTeam != null)
            ShowTeam(
              // Показ информации о моей команде
              team: context.read<Tournament>().myTeam!,
            ),
        ],
      ),
    );
  }
}
