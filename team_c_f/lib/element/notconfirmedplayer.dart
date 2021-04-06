import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/data/player.dart';

class PlayerToComfirm extends StatelessWidget {
  // Класс, для отображения неподтвержденных игроков
  Player player; // Неподтвержденный игрок
  PlayerToComfirm({Key key, @required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(player.name),
          SizedBox(width: 10),
          InkWell(
            // Кнопка подтверждения
            child: Icon(
              Icons.check_box,
              size: 30,
              color: Colors.green,
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: 'Click done',
              );
            },
          ),
          SizedBox(width: 10),
          InkWell(
            // Кнопка отклонения
            child: Icon(
              Icons.cancel,
              size: 30,
              color: Colors.red,
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: 'Click cancel',
              );
            },
          ),
        ],
      ),
    );
  }
}
