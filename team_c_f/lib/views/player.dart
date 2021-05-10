import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/servises/servises.dart';
import 'package:team_c_f/storebloc/blocs/myteam.dart';
import 'package:provider/provider.dart';

class ShowPlayer extends StatelessWidget {
  // Класс отображающий информацию об указанном игроке
  final PlayerData player;
  ShowPlayer({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyTeamBloc bloc = context.watch<MyTeamBloc>();
    return Container(
      child: InkWell(
        onLongPress: () async {
          if (bloc.state.capitan &&
              (await showAlertDialog(
                context: context,
                title: 'Изменение состава',
                message: 'Удалить ${player.name}',
                actions: [
                  AlertDialogAction<bool>(
                    key: true,
                    label: 'Да, удалить',
                    isDefaultAction: true,
                  ),
                  AlertDialogAction<bool>(
                    key: false,
                    label: 'Отмена',
                    isDestructiveAction: true,
                  ),
                ],
              ))!) {
                bloc.state.selectId = player.uid;
                bloc.add(MyTeamEvent.unconfirmedPlayer);
          }
        },
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(player.prevPosition.toString()),
            ),
            title: Text(player.name),
            trailing: Text(
              showGoals(player.goals),
            ),
          ),
        ),
      ),
    );
  }
}
