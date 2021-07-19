import 'package:flutter/material.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:intl/intl.dart';

class MeetView extends StatelessWidget {
  final MeetData meetData;
  const MeetView({Key? key, required this.meetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd HH:mm').parse(meetData.date);
    String status = meetData.status == 'Не начат'
        ? date.day == DateTime.now().day
            ? DateFormat('HH:mm').format(date)
            : DateFormat('dd.MM').format(date)
        : meetData.status;
    String score = meetData.started
        ? '${meetData.score.first}:${meetData.score.last}'
        : '-';
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: meetData.started ? Colors.green[100] : Colors.yellow[300],
        width: width - 15,
        child: Column(
          children: [
            Table(
              columnWidths: {
                0: FixedColumnWidth(width/6.5),
                1: FixedColumnWidth(width/3),
                2: FixedColumnWidth(width/10),
                3: FixedColumnWidth(width/3)
              },
              children: [
                TableRow(
                  children: [
                    Text(status, textAlign: TextAlign.center),
                    Text(meetData.team.first, textAlign: TextAlign.right),
                    Text(score, textAlign: TextAlign.center),
                    Text(meetData.team.last),
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
