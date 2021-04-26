import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/old/data/shortmatch.dart';
import 'package:team_c_f/old/servise/htmlparse.dart';
import 'package:team_c_f/old/servise/make.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:http/http.dart' as http;

class SelectMatch extends StatefulWidget {
  // Отображение выбора 10 матчей на тур
  final String stage;
  SelectMatch({Key? key, required this.stage}) : super(key: key);

  @override
  _SelectMatchState createState() => _SelectMatchState();
}

class _SelectMatchState extends State<SelectMatch> {
  List<String> range = [];
  List<DateTime> period = [];

  get stage => widget.stage;

  Future<void> download() async {
    range.forEach(
      (date) {
        http.Client()
            .get(Uri.parse('https://www.sports.ru/football/match/$date/'))
            .then((value) {
          context.read<DataMatch>().add(
            [
              ...getMatchs(
                body: value.body,
                date: '$date',
              )
            ],
          );
        });
      },
    );
  }

  Widget home() {
    int count = context
        .watch<DataMatch>()
        .data
        .where((ShortMatch match) => match.selected)
        .length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбери матчи на ' +
            '${!stage.contains(' ') ? '$stage тур' : '$stage'}'),
      ),
      body: Container(
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
                  context.read<DataMatch>().data.clear();
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
            ...makeDays(context.read<DataMatch>().data),
            ElevatedButton(
              onPressed: count == 10
                  ? () {
                      Navigator.pop(
                        context,
                        [
                          ...context
                              .read<DataMatch>()
                              .data
                              .where((element) => element.selected)
                        ],
                      );
                    }
                  : null,
              child: Text('Добавить матчи'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }
}
