import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';
import 'package:intl/intl.dart';

class MatchView extends StatelessWidget {
  // Показ одного выбранного матча для прогнозирования
  final Match match;
  const MatchView({Key key, this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> score = match.score != '' ? match.score.split(':') : ['', ''];
    return Container(
      width: MediaQuery.of(context).size.shortestSide / 2 - 10,
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            match.date == DateFormat('yyyy-MM-dd').format(DateTime.now())
                ? match.time
                : DateFormat('dd.MM').format(
                    DateTime.parse(match.date),
                  ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${match.home}',
                textAlign: TextAlign.start,
              ),
              Text(
                '${score[0]}',
                textAlign: TextAlign.end,
              ),
            ],
          ),
          Text(
            '${match.away} ${score[1]}',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
