import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:team_c_f/data/player.dart';

class ShowPlayer extends StatelessWidget {
  // Класс отображающий информацию об указанном игроке
  final PlayerData player;
  ShowPlayer({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onLongPress: () async {
          // if (context.read<Tournament>().me.capitan &&
          //     (await showAlertDialog(
          //       context: context,
          //       title: 'Изменение состава',
          //       message: 'Удалить ${player.name}',
          //       actions: [
          //         AlertDialogAction<bool>(
          //           key: true,
          //           label: 'Да, удалить',
          //           isDefaultAction: true,
          //         ),
          //         AlertDialogAction<bool>(
          //           key: false,
          //           label: 'Отмена',
          //           isDestructiveAction: true,
          //         ),
          //       ],
          //     ))!) {
          //   context.read<Tournament>().removePlayerFromMyTeam(uid: player.uid);
          // }
        },
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(player.prevPosition.toString()),
            ),
            title: Text(player.name),
            trailing: Text(player.goals.toString()),
            //showPoints(player.points)),
          ),
        ),
      ),
    );
  }
}
