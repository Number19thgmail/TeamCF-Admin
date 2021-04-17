import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/meet.dart';
import 'package:team_c_f/element/match.dart';

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
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ...selectTour.matches
                            .map((match) => MatchView(match: match)),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<DataShortMatch>().matchSelectingStart();
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
