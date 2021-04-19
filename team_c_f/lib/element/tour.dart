import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/meet.dart';
import 'package:team_c_f/element/match.dart';
import 'package:team_c_f/page/leaveforecast.dart';
import 'package:team_c_f/page/selectmatch.dart';

class ShowTour extends StatefulWidget {
  // Класс, отображающий результаты выбранного тура тура
  final String tour;
  ShowTour({Key key, this.tour}) : super(key: key);

  @override
  _ShowTourState createState() => _ShowTourState();
}

class _ShowTourState extends State<ShowTour> {
  Tour selectTour;

  @override
  void initState() {
    super.initState();
    context
        .read<Tournament>()
        .getTour(
            tour: widget.tour == null
                ? context.read<Tournament>().selectTour
                : widget.tour)
        .then(
          (value) => setState(
            () {
              selectTour = value;
            },
          ),
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
                    leading: Text(selectTour.tour),
                    title: Text(
                        '${selectTour.matches.where((element) => element.started).length}/10 матчей')),
              ),
              SizedBox(height: 20),
              selectTour.matches.length == 10
                  ? Column(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...selectTour.matches
                                .map((match) => MatchView(match: match)),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return LeaveForecast(
                                    stage: selectTour.tour,
                                  );
                                },
                              ),
                            );
                          },
//!
                          child: Text('Оставить прогноз'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<List<ShortMatch>>(
                            builder: (BuildContext context) {
                              return SelectMatch(stage: selectTour.tour);
                              //return SelectMatch(stage: selectTour.tour);
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
                  ...selectTour.pair.map((pair) => MeetView(match: pair)),
                ],
              ),
            ],
          )
        : Text('Загрузка данных тура');
  }
}
