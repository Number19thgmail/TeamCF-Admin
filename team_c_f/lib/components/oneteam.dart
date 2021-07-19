import 'package:flutter/material.dart';
import 'package:team_c_f/storebloc/blocs/leaveforecast.dart';
import 'package:team_c_f/storebloc/models/leaveforecast.dart';
import 'package:provider/provider.dart';

class OneTeamView extends StatelessWidget {
  final LeaveForecastModel forecast;
  OneTeamView({Key? key, required this.forecast}) : super(key: key);

  final List<int> numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    LeaveForecastBloc bloc = context.read<LeaveForecastBloc>();
    double size = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.blue[400],
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FixedColumnWidth(size / 7),
          1: FixedColumnWidth(size / 3),
          2: FixedColumnWidth(size / 11),
          3: FixedColumnWidth(size / 40),
          4: FixedColumnWidth(size / 11),
          5: FixedColumnWidth(size / 3),
        },
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(forecast.date),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  forecast.teams.first,
                  textAlign: TextAlign.right,
                ),
              ),
              DropdownButton<int>(
                value: forecast.home,
                onChanged: (i) {
                  bloc.add(
                    LeaveForecastEvent(
                        event: Event.changeValue,
                        position: true,
                        index: bloc.state.meets.indexOf(forecast),
                        newValue: i),
                  );
                },
                items: [
                  ...numbers.map<DropdownMenuItem<int>>(
                    (int number) => DropdownMenuItem(
                      child: Text(number.toString()),
                      value: number,
                    ),
                  ),
                ],
              ),
              Text(':'),
              DropdownButton<int>(
                value: forecast.away,
                onChanged: (i) {
                  bloc.add(
                    LeaveForecastEvent(
                        event: Event.changeValue,
                        position: false,
                        index: bloc.state.meets.indexOf(forecast),
                        newValue: i),
                  );
                },
                items: [
                  ...numbers.map<DropdownMenuItem<int>>(
                    (int number) => DropdownMenuItem(
                      child: Text(number.toString()),
                      value: number,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  forecast.teams.last,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
