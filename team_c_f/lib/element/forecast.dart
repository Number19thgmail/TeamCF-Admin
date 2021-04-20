import 'package:flutter/material.dart';
import 'package:team_c_f/data/match.dart';
import 'package:team_c_f/element/tour.dart';
import 'package:team_c_f/page/leaveforecast.dart';

class ForecastView extends StatefulWidget {
  final int index;
  final Match match;
  ForecastView({
    Key key,
    @required this.match,
    @required this.index,
  }) : super(key: key);

  @override
  _ForecastViewState createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  String home;
  String away;
  List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  int get index => widget.index;
  @override
  void initState() {
    super.initState();
    home = LeaveForecast.rate[index].split('-')[0];
    if (home == '') home = null;
    away = LeaveForecast.rate[index].split('-')[1];
    if (away == '') away = null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> date = widget.match.date.split('-');
    date.removeAt(0);
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        color: Colors.deepPurple[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(date[1] + '.' + date[0]),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.match.home),
                      // SizedBox(width: 20),
                      DropdownButton<String>(
                        value: home,
                        onChanged: (result) {
                          setState(
                            () {
                              home = result;
                              LeaveForecast.rate[index] = home +
                                  '-' +
                                  LeaveForecast.rate[index].split('-')[1];
                            },
                          );
                        },
                        items: [
                          ...numbers.map<DropdownMenuItem<String>>(
                            (String number) => DropdownMenuItem(
                              child: Text(number),
                              value: number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.match.away),
                      // SizedBox(width: 20),
                      DropdownButton<String>(
                        value: away,
                        onChanged: (result) {
                          setState(
                            () {
                              away = result;
                              LeaveForecast.rate[index] =
                                  LeaveForecast.rate[index].split('-')[0] +
                                      '-' +
                                      away;
                            },
                          );
                        },
                        items: [
                          ...numbers.map<DropdownMenuItem<String>>(
                            (String number) => DropdownMenuItem(
                              child: Text(number),
                              value: number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
