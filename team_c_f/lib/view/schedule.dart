import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/schedule.dart';

class ShowSchedules extends StatefulWidget {
  // Класс, отображающий результаты тура, по умолчанию текущего
  const ShowSchedules({Key key}) : super(key: key);

  @override
  _ShowSchedulesState createState() => _ShowSchedulesState();
}

class _ShowSchedulesState extends State<ShowSchedules> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Выберите тур',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...context.read<Tournament>().schedule.map((tour) {
                return TourView(tour: tour);
              }).toList()
            ],
          ),
        ],
      ),
    );
  }
}
