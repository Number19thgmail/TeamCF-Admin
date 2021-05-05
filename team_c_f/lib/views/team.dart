import 'package:flutter/material.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/views/player.dart';

class ShowTeam extends StatelessWidget {
  // Класс отображения информации об указанной команде
  final TeamData team; // Команда
  ShowTeam({Key? key, required this.team}) : super(key: key);

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
                  team.prevPosition.toString(),
                ),
              ),
              title: Text(team.name),
              trailing: Text(
                team.points.toString()
                //showPoints(team.points),
              ),
            ),
          ),
          Container(
            // Информация об участниках команды
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ...team.players.map(
                  (String uid) => ShowPlayer(
                      player: Data.players
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
