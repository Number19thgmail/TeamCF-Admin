import 'package:flutter/material.dart';
import 'package:team_c_f/data/data.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/servise/htmlparse.dart';
import 'package:team_c_f/servise/make.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:http/http.dart' as http;
import 'package:team_c_f/data/push.dart';

class SelectMatch extends StatefulWidget { // Отображение выбора 10 матчей на тур
  SelectMatch({Key key}) : super(key: key);

  @override
  _SelectMatchState createState() => _SelectMatchState();
}

class _SelectMatchState extends State<SelectMatch> {
  List<String> range = [];
  List<DateTime> period = [];

  Future<void> download() async {
    range.forEach(
      (date) {
        http.Client()
            .get(Uri.parse('https://www.sports.ru/football/match/$date/'))
            .then((value) {
          context.read<DataShortMatch>().addData([
            ...getMatchs(
              body: value.body,
              date: '$date',
            )
          ]);
        });
      },
    );
  }

  Widget home(int count) {
    return Container(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              range.clear();
              DateRangePicker.showDatePicker(
                context: context,
                initialFirstDate: DateTime.now(),
                initialLastDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2040),
              ).then((value) {
                setState(() {
                  period = value;
                  for (DateTime i = value.first;
                      i.isBefore(value.last.add(Duration(minutes: 1)));
                      i = i.add(Duration(days: 1))) {
                    range.add(DateFormat('yyyy-MM-dd').format(i));
                  }
                });
                context.read<DataShortMatch>().clearData();
                download();
              });
            },
            child: Text('Выбрать даты'),
          ),
          Text(
            '$count/10',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: count > 10 ? Colors.red : Colors.green,
            ),
          ),
          ...makeDays(context.watch<DataShortMatch>().getData),
          ElevatedButton(
            onPressed: count == 10
                ? () {
                    context.read<Tournament>().createMatchesForTour(
                      matches: [
                        ...context
                            .read<DataShortMatch>()
                            .getData
                            .where((element) => element.selected)
                      ],
                      stage: context.read<Tournament>().selectTour,
                    );
                    context.read<DataShortMatch>().matchSelectingEnd();
                  }
                : null,
            child: Text('Добавить матчи'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DataShortMatch>().matchSelectingEnd();
            },
            child: Text('Отмена'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return home(context.watch<DataShortMatch>().countSelected);
  }
}
