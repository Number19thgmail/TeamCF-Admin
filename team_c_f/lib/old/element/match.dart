import 'package:flutter/material.dart';
import 'package:team_c_f/old/data/match.dart';
import 'package:intl/intl.dart';

class MatchView extends StatelessWidget {
  // Показ одного выбранного матча для прогнозирования
  final Match match;
  const MatchView({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> score = match.score != '' ? match.score.split(':') : ['', ''];
    return Container(
      width: MediaQuery.of(context).size.shortestSide / 2 - 10,
      //padding: const EdgeInsets.all(1.0),
      color: Colors.green,
      child: Card(
        child: Column(
          children: [
                Text(
                  match.date == DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ? match.time
                      : DateFormat('dd.MM').format(
                          DateTime.parse(match.date),
                        ),
                  textAlign: TextAlign.center,
                ),
            Table(
              columnWidths: {1: FractionColumnWidth(.15)},
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '${match.home}',
                        textAlign: TextAlign.start,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '${score[0]}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '${match.away}',
                        textAlign: TextAlign.start,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '${score[1]}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
