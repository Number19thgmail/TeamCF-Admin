import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/store/team/team.dart';

class PlayerToConfirm extends StatelessWidget {
  // Класс, для отображения неподтвержденных игроков
  final PlayerData player; // Неподтвержденный игрок
  final Team team;
  PlayerToConfirm({Key? key, required this.player, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(player.name),
          ),
          IconButton(
            icon: Icon(
              Icons.check_box,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () {
              team.addWin();
              //Data.players.where((PlayerData p) => p.uid == player.uid).single.name = 'New name 4';
              Fluttertoast.showToast(
                msg: '${player.name} добавлен в вашу команду',
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              // context
              //     .read<Tournament>()
              //     .confirmPlayer(uid: player.uid, confirm: false);
              Fluttertoast.showToast(
                msg: 'Заявка отклонена',
              );
            },
          ),
        ],
      ),
    );
  }
}
