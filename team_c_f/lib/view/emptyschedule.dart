import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/createschedule.dart';
import 'package:team_c_f/element/tour.dart';
import 'package:team_c_f/view/schedule.dart';

class ScheduleView extends StatefulWidget {
  // Если расписание отсутствует
  const ScheduleView({Key key}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return context.watch<Tournament>().schedule.isNotEmpty
        ? context.watch<Tournament>().selectTour == ''
            ? ShowSchedules()
            : Container(
              width: double.infinity,
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<Tournament>().select('');
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text(
                        'Выбрать другой тур',
                      ),
                    ),
                    ShowTour(),
                  ],
                ),
              )
        : CreateSchedule();
  }
}
