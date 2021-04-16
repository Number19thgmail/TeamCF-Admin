import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/meet.dart';
import 'package:team_c_f/element/match.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
                  OneSignal.shared.getPermissionSubscriptionState().then(
                    (status) {
                      OneSignal().postNotificationWithJson(
                        {
                          'app_id': '93b27d54-e442-4af5-86e4-a215faf20e3a',
                          'heading': {
                            'ru': 'Title',
                            'en': 'Title',
                          },
                          'contents': {
                            'ru': 'Группе currentUser',
                            'en': 'Group',
                          },
                          'included_segments': ['currentUser'],
                          // 'playerIds': [
                          //   '493cb552-64c9-4b3d-a5af-fc6877926741',
                          //   'fb358c70-8c52-407f-9234-0421392dc1d4'
                          // ],
                          // 
                          // 'include_player_ids': [
                          //   'fb358c70-8c52-407f-9234-0421392dc1d4'
                          // ],
                        },
                      );
                      OneSignal().postNotification(
                        OSCreateNotification(
                          heading: 'Отложенное уведомление',
                          content: 'Уведомление на 2 устройства',
                          playerIds: [
                            '493cb552-64c9-4b3d-a5af-fc6877926741',
                            'fb358c70-8c52-407f-9234-0421392dc1d4'
                          ],
                          sendAfter: DateTime(2021, 4, 15, 18, 06),
                        ),
                      );
                    },
                  );
                },
                child: Text('Запросить пуш'),
              ),
            ],
          )
        : Text('Загрузка данных тура');
  }
}
