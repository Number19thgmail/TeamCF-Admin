import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/servises/servises.dart';
import 'package:team_c_f/storebloc/models/team.dart';
import 'package:team_c_f/views/player.dart';

class ShowTeam extends StatelessWidget {
  // Класс отображения информации об указанной команде
  final TeamModel team; // Команда
  ShowTeam({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Card(
            color: Colors.cyan[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Observer(
              builder: (_) => ListTile(
                // Информация о команде
                leading: CircleAvatar(
                  child: Text(
                    team.team.prevPosition.toString(),
                  ),
                ),
                title: Text(team.team.name),
                trailing: Text(
                  //team.team.points.toString()
                  showPoints(team.points),
                ),
              ),
            ),
          ),
          Container(
            // Информация об участниках команды
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ...team.team.players.map(
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
