import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/storebloc/blocs/myteam.dart';
import 'package:team_c_f/storebloc/models/unconfirmedplayer.dart';
import 'package:provider/provider.dart';

class UnconfirmedPlayerView extends StatelessWidget {
  // Класс, для отображения неподтвержденных игроков
  final UnconfirmedPlayerModel player; // Неподтвержденный игрок
  UnconfirmedPlayerView({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyTeamBloc bloc = context.watch<MyTeamBloc>();
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
              bloc.state.selectId = player.uid;
              bloc.add(MyTeamEvent.confirmedPlayer);
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
              bloc.state.selectId = player.uid;
              bloc.add(MyTeamEvent.unconfirmedPlayer);
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
