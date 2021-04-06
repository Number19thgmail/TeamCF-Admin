import 'package:flutter/material.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:team_c_f/servise/make.dart';

class DayView extends StatefulWidget {
  // Класс, отобращающий все соревнования, в которых есть матчи, в текущий день
  final String date; // Дата
  final List<ShortMatch> matches; // Список матчей для отображения
  const DayView({
    Key key,
    @required this.date,
    @required this.matches,
  }) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  String get date => widget.date;
  List<ShortMatch> get matches => widget.matches;
  bool hide = true; // Флаг, показывающий скрывать ли список соревнований

  @override
  Widget build(BuildContext context) {
    int count = matches
        .where((element) => element.selected)
        .length; // Подсчет матчей, выбранных в этом дне
    String selected = ((count % 10 == 1) & (count / 10 != 1))
        ? '$count выбран'
        : '$count выбрано';
    selected = count > 0 ? '($selected)' : '';
    return Container(
      color: Colors.lime,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onSurface: Colors.orange,
                padding: const EdgeInsets.all(8.0),
              ),
              child: Text(
                '$date$selected',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                setState(() {
                  // Изменение отображения или скрытия матчей
                  hide = !hide;
                });
              },
            ),
          ),
          hide
              ? SizedBox()
              : [
                  ...makeTournaments(
                      matches: widget.matches), // Создание списка соревнований
                ],
        ],
      ),
    );
  }
}
