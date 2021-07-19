import 'package:flutter/material.dart';

class MeetView extends StatelessWidget { // Показ одного выбранного матча для прогнозирования
  final String match;
  const MeetView({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> team = match.split(' - ');
    String score = ' - ';
    return Container(
      child: Column(
        children: [Text(team[0] + score + team[1])],
      ),
    );
  }
}
