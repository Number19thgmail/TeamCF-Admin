import 'package:flutter/material.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:provider/provider.dart';

class TeamView extends StatefulWidget {
  const TeamView({Key key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  @override
  Widget build(BuildContext context) {
    Player me = context
        .read<Tournament>()
        .allPlayers
        .where(
          (player) => player.itIsMe(uid: context.read<Account>().userId),
        )
        .first;
    Team myTeam = context
        .read<Tournament>()
        .allTeams
        .where((team) => team.title == me.team)
        .first;
    Player myCapitan = context
        .read<Tournament>()
        .allPlayers
        .where((player) => player.team == me.team && player.capitan)
        .first;
    return Container(
      child: ListTile(
        tileColor: Colors.red,
        leading: Text(
          myTeam.position.toString(),
        ),
        title: Row(
          children: [
            Text(me.team),
            Icon(me.confirmed ? Icons.done : Icons.not_interested),
          ],
        ),
        subtitle: Row(
          children: [
            Text(me.confirmed
                ? 'Капитан команды ${myCapitan.name}'
                : '${myCapitan.name} ещё не подтвердил твоё участие'),
          ],
        ),
      ), //Text('Информация о команде'),
    );
  }
}

// Container(
//   child: ElevatedButton(
//     onPressed: () {
//       signOutGoogle(context: context)
//           .then((value) => context.read<Account>().updateSignInfo());
//     },
//     child: Text('Home screen will be here'),
//   ),
// ),
