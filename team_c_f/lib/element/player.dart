import 'package:flutter/material.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/servise/make.dart';

class ShowPlayer extends StatelessWidget {
  // Класс отображающий информацию об указанном игроке
  final Player player;
  ShowPlayer({Key key, @required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(player.position.toString()),
          ),
          title: Text(player.name),
          trailing: Text(showPoints(player.points)),
        ),
      ),
    );
  }
}
