import 'package:flutter/material.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:intl/intl.dart';

class MeetView extends StatelessWidget {
  final MeetData meetData;
  const MeetView({Key? key, required this.meetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd HH:mm').parse(meetData.date);
    String status = meetData == 'Не начат'
        ? date.day == DateTime.now().day
            ? DateFormat('HH:mm').format(date)
            : DateFormat('dd.MM').format(date)
        : meetData.status;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: meetData.started ? Colors.green[100] : Colors.yellow[200],
        width: MediaQuery.of(context).size.width / 2 - 15,
        child: Column(
          children: [
            Text(status),
            Table(
              columnWidths: {
                0: IntrinsicColumnWidth(flex: 0.9),
                1: IntrinsicColumnWidth(flex: 0.1)
              },
              children: [
                TableRow(
                  children: [
                    Text(meetData.team.first),
                    if (!meetData.started)
                      Text(
                        meetData.score.first.toString(),
                        textAlign: TextAlign.right,
                      ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(meetData.team.last),
                    if (!meetData.started)
                      Text(
                        meetData.score.last.toString(),
                        textAlign: TextAlign.right,
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
