import 'package:flutter/material.dart';
import 'package:team_c_f/old/data/match.dart';
import 'package:team_c_f/old/page/leaveforecast.dart';

class ForecastView extends StatefulWidget {
  final int index;
  final Match match;
  ForecastView({
    Key? key,
    required this.match,
    required this.index,
  }) : super(key: key);

  @override
  _ForecastViewState createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  String? home;
  String? away;
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
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {1: FractionColumnWidth(0.7)},
          children: [
            TableRow(
              children: [
                Text(date[1] + '.' + date[0], textAlign: TextAlign.center,),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {1: FractionColumnWidth(0.2)},
                  children: [
                    TableRow(
                      children: [
                        Text(
                          widget.match.home,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                        DropdownButton<String>(
                          value: home,
                          onChanged: (result) {
                            setState(
                              () {
                                home = result;
                                LeaveForecast.rate[index] = home! +
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
                    TableRow(
                      children: [
                        Text(
                          widget.match.away,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                        DropdownButton<String>(
                          value: away,
                          onChanged: (result) {
                            setState(
                              () {
                                away = result;
                                LeaveForecast.rate[index] =
                                    LeaveForecast.rate[index].split('-')[0] +
                                        '-' +
                                        away!;
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
          ],
        ),
      ),
    );
  }
}
