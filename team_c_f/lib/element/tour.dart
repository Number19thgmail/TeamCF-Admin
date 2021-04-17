import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/push.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/meet.dart';
import 'package:team_c_f/element/match.dart';
import 'package:http/http.dart' as http;

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
              ElevatedButton(
                onPressed: () async {
                  Uri url =
                      Uri.parse('https://onesignal.com/api/v1/notifications');
                  Map<String, String> headers = {};
                  headers['authorization'] =
                      'Basic ODkyZTdlNDUtM2Y0Yy00MDQ0LThjYmMtY2MxMzljMzQ1YzQ5';
                  headers['Content-Type'] = 'application/json; charset=utf-8';
                  String s =
                      '{\"app_id\": \"93b27d54-e442-4af5-86e4-a215faf20e3a\",\"contents\": {\"en\": \"English Message\", \"ru\": \"Russian Message\"},\"headings\" : {\"en\": \"English Title\", \"ru\": \"Russian Title\"},\"included_segments\": [\"Subscribed Users\"]}';
                  var body = Push(enTitle: 'Title English', enContent: 'Content English', ruTitle: 'Title RU', ruContent: 'Content RU').toMap();
                  http
                      .post(url, headers: headers, body: body)
                      .then((value) => print(value.body));
                },
                child: Text('Запросить пуш'),
              ),
            ],
          )
        : Text('Загрузка данных тура');
  }
}
