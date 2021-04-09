import 'package:flutter/material.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/player.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/servise/make.dart';

class ShowTeam extends StatelessWidget {
  // Класс отображения информации об указанной команде
  final Team team; // Команда
  ShowTeam({Key key, @required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            child: ListTile(
              // Информация о команде
              leading: CircleAvatar(
                child: Text(
                  team.position.toString(),
                ),
              ),
              title: Text(team.title),
              trailing: Text(
                showPoints(team.points),
              ),
            ),
          ),
          Container(
            // Информация об участниках команды
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ...team.members.map(
                  (String uid) => ShowPlayer(
                      player: context
                          .read<Tournament>()
                          .allPlayers
                          .where((player) => player.uid == uid)
                          .first),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
