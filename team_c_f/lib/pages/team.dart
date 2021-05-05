import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_c_f/components/confirmedplayer.dart';
import 'package:team_c_f/components/selectteam.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:team_c_f/store/myteam/myteam.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/views/team.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyTeam state = MyTeam(
        player: Data.players
            .where((PlayerData p) => p.uid == context.read<Login>().userId)
            .single);
    return Observer(
      builder: (_) => state.team != null
          ? Column(
              children: [
                Card(
                  color: Colors.red[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: ListTile(
                    leading: CircleAvatar(
                      // Показывает место в таблице бомбардиров
                      backgroundColor: Colors.blue[100],
                      child: Text(state.me.prevPosition.toString()),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.me.name), // Показывает имя участника
                      ],
                    ),
                    subtitle: state.me.team != null
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Показываем статус игрока, подтвержден ли он капитаном команды
                              Icon(Icons.done,
                                  color: state.team!.team.players
                                              .where((String uid) =>
                                                  uid == state.me.uid)
                                              .length ==
                                          1
                                      ? Colors.green
                                      : Colors.grey),
                              Text(state.me.team!),
                            ],
                          )
                        : SelectTeamView(
                            selectTeam: context.read<Login>().selectTeam),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            context.read<Login>().googleLogout();
                          }),
                    ),
                  ),
                ),
                if (state.team != null)
                  if (state.team!.team.uidCapitan == state.me.uid)
                    // Отображение для капитана списка игроков, которые зарегистрировались, но ещё не получили подтверждение в его команде
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ...state.unconfirmPlayer.map(
                            (PlayerData p) =>
                                PlayerToConfirm(player: p, team: state.team!),
                          ),
                        ],
                      ),
                    ),
                if (state.team != null)
                  ShowTeam(
                    // Показ информации о моей команде
                    team: state.team!.team,
                  ),
              ],
            )
          : Text('Загрузка'),
    );
  }
}
