import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/shortmatch.dart';

class MatchView extends StatefulWidget {
  // Класс, отображащий информацию о матче, при выборе матчей
  final ShortMatch match; // Краткая информация о матче
  const MatchView({
    Key key,
    @required this.match,
  }) : super(key: key);

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  Color color = Colors.amber;

  get home => widget.match.home;
  get away => widget.match.away;
  get time => widget.match.time;
  get selected => widget.match.selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      // Карточка с информацией о матче
      color: selected ? Colors.blue : Colors.amber,
      child: CheckboxListTile(
        checkColor: Colors.blue,
        activeColor: Colors.amber,
        value: selected,
        title: Text('$time. $home - $away'),
        onChanged: (a) {
          context.read<DataMatch>().selectMatch(widget.match, a);
        },
      ),
    );
  }
}
