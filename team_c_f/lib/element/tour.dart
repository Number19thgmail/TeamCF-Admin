import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/schedule.dart';

class ShowTour extends StatefulWidget {
  // Класс, отображающий результаты выбранного тура тура
  final String tour;
  ShowTour({Key key, this.tour}) : super(key: key);

  @override
  _ShowTourState createState() => _ShowTourState();
}

class _ShowTourState extends State<ShowTour> {
  @override
  Widget build(BuildContext context) {
    return widget.tour == null
        ? Text(
            'Просмотр выбранного тура',
          )
        : Text(
            'Выбран текущий тур',
          );
  }
}
