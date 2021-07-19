import 'package:flutter/material.dart';
import 'package:team_c_f/components/meet.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:intl/intl.dart';

class ShowMeets extends StatelessWidget {
  final MeetsModel meetsModel;
  const ShowMeets({Key? key, required this.meetsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime deadline =
        DateFormat('yyyy-MM-dd HH:mm').parse(meetsModel.deadline);
    String day;
    switch (deadline.weekday) {
      case 1:
        day = 'понедельник';
        break;
      case 2:
        day = 'вторник';
        break;
      case 3:
        day = 'среду';
        break;
      case 4:
        day = 'четверг';
        break;
      case 5:
        day = 'пятницу';
        break;
      case 6:
        day = 'субботу';
        break;
      default:
        day = 'воскресенье';
        break;
    }
    String date = DateFormat('dd.MM').format(deadline);
    String time = DateFormat('HH:mm').format(deadline);
    return Container(
      child: Column(
        children: [
          if (!meetsModel.started)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Дедлайн в ' + day + ' ' + date + ' в ' + time + ' по МСК'),
            ),
          Wrap(
            children: [
              ...meetsModel.meets.map(
                (MeetData meetData) => MeetView(
                  meetData: meetData,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
