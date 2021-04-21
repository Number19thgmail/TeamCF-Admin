import 'package:flutter/material.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/element/forecast.dart';
import 'package:team_c_f/data/match.dart';

class LeaveForecast extends StatefulWidget {
  final Tour tour;
  const LeaveForecast({Key key, this.tour}) : super(key: key);

  static List<String> rate = ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-'];

  @override
  _LeaveForecastState createState() => _LeaveForecastState();
}

class _LeaveForecastState extends State<LeaveForecast> {
  @override
  Widget build(BuildContext context) {
    String stage = widget.tour.tour;
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз на ' +
            '${!stage.contains(' ') ? '$stage тур' : '$stage'}'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...widget.tour.matches
                      .map(
                        (Match match) => ForecastView(
                          match: match,
                          index: widget.tour.matches.indexOf(match),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: enableForecasting()
                  ? () {
                      Navigator.pop(
                        context,
                        [...LeaveForecast.rate],
                      );
                    }
                  : null,
              child: Text('Оставить прогноз'),
            ),
          ],
        ),
      ),
    );
  }

  bool enableForecasting() {
    bool key = true;
    LeaveForecast.rate.forEach(
      (match) {
        if (match.split('-').where((goal) => goal == '').length != 0)
          key = false;
      },
    );
    return key;
  }
}
