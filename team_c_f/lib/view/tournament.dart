import 'package:flutter/material.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:team_c_f/view/match.dart';

class TournamentView extends StatefulWidget {
  final List<ShortMatch> matches;
  final String tournament;
  const TournamentView({
    Key key,
    @required this.tournament,
    @required this.matches,
  }) : super(key: key);

  @override
  _TournamentViewState createState() => _TournamentViewState();
}

class _TournamentViewState extends State<TournamentView> {
  bool hide = true;
  String get tournament => widget.tournament;
  List<ShortMatch> get matches => widget.matches;
  Widget showMatch() {
    return Column(
      children: [
        ...widget.matches.map((e) => MatchView(match: e)).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int count = matches.where((element) => element.selected).length;
    String selected = ((count % 10 == 1) & (count / 10 != 1))
        ? '$count выбран'
        : '$count выбрано';
    selected = count > 0 ? '($selected)' : '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(
                '$tournament$selected',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                setState(() {
                  hide = !hide;
                });
              },
            ),
          ),
          hide ? SizedBox() : showMatch(),
        ],
      ),
    );
  }
}
