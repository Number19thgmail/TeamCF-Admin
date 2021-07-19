import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/old/data/forecast.dart';
import 'package:team_c_f/old/data/schedule.dart';
import 'package:team_c_f/old/data/shortmatch.dart';
import 'package:team_c_f/old/data/tournament.dart';
import 'package:team_c_f/old/element/meet.dart';
import 'package:team_c_f/old/element/match.dart';
import 'package:team_c_f/old/page/leaveforecast.dart';
import 'package:team_c_f/old/page/selectmatch.dart';

class ShowTour extends StatefulWidget {
  // Класс, отображающий результаты выбранного тура тура
  final String? tour;
  ShowTour({Key? key, this.tour}) : super(key: key);

  @override
  _ShowTourState createState() => _ShowTourState();
}

class _ShowTourState extends State<ShowTour> {
  Tour? selectTour;
  bool leaveForecast = false;

  @override
  void initState() {
    super.initState();
    context
        .read<Tournament>()
        .getTour(
            tour: (widget.tour == null
                ? context.read<Tournament>().selectTour
                : widget.tour)!)
        .then(
      (value) {
        setState(
          () {
            selectTour = value;
          },
        );
        context.read<Tournament>().checkForecast(stage: selectTour!.tour).then(
          (bool response) async {
            LeaveForecast.rate = response
                ? (await context
                    .read<Tournament>()
                    .getCurrentForecast(stage: selectTour!.tour)).rate
                : ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-'];
            setState(() {
              leaveForecast = response;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return selectTour != null
        ? Column(
            children: [
              Card(
                color: Colors.yellow,
                child: ListTile(
                  leading: Text(selectTour!.tour),
                  title: Text(
                      '${selectTour!.matches.where((element) => element.started).length}/10 матчей'),
                ),
              ),
              SizedBox(height: 20),
              selectTour!.matches.length == 10
                  ? Column(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...selectTour!.matches
                                .map((match) => MatchView(match: match)),
                          ],
                        ),
                        if (DateTime.now().isBefore(selectTour!.deadline))
                          Column(
                            children: [
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<List<String>>(
                                      builder: (BuildContext context) {
                                        return LeaveForecast(
                                          tour: selectTour!,
                                        );
                                      },
                                    ),
                                  ).then(
                                    (List<String>? value) {
                                      //context.read<Tournament>()
                                      //! отправка прогноза
                                      if (value != null) {
                                        context
                                            .read<Tournament>()
                                            .makeForecast(
                                              forecast: Forecast(
                                                  rate: [...LeaveForecast.rate],
                                                  team: '',
                                                  tour: '',
                                                  userId: ''),
                                            )
                                            .then(
                                              (bool response) => setState(
                                                () => leaveForecast = response,
                                              ),
                                            );
                                      }
                                    },
                                  );
                                },
                                child: Text(leaveForecast
                                    ? 'Изменить прогноз'
                                    : 'Оставить прогноз'),
                              ),
                            ],
                          ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<List<ShortMatch>>(
                            builder: (BuildContext context) {
                              return SelectMatch(stage: selectTour!.tour);
                            },
                          ),
                        ).then(
                          (value) {
                            if (value != null)
                              context.read<Tournament>().createMatchesForTour(
                                matches: [...value],
                                stage: context.read<Tournament>().selectTour,
                              );
                          },
                        );
                      },
                      child: Text('Выбрать матчи')),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...selectTour!.pair.map((pair) => MeetView(match: pair)),
                ],
              ),
            ],
          )
        : Text('Загрузка данных тура');
  }
}
