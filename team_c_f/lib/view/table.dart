import 'package:flutter/material.dart';
import 'package:team_c_f/data/push.dart';

import 'package:http/http.dart' as http;

class ShowTable extends StatelessWidget {
  // Класс, отображающий туры, с возможностью их выбора для просмотра
  const ShowTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Турнирная таблица'),
          ElevatedButton(
            onPressed: () async {
              Uri url = Uri.parse('https://onesignal.com/api/v1/notifications');
              Map<String, String> headers = {};
              headers['authorization'] =
                  'Basic ODkyZTdlNDUtM2Y0Yy00MDQ0LThjYmMtY2MxMzljMzQ1YzQ5';
              headers['Content-Type'] = 'application/json; charset=utf-8';
              String notifyNow = Push(
                enTitle: 'Title English',
                enContent: 'Content English',
                ruTitle: 'Заголовок',
                ruContent: 'Контекст',
              ).toJson();
              String notifyDayToDeadline = Push(
                enTitle: 'Title English',
                enContent: 'Content English',
                ruTitle: 'Title RU',
                ruContent: 'Content RU',
                date: DateTime.now().add(Duration(minutes: 2)),
              ).toJson();
              String notifyHourToDeadline = Push(
                enTitle: 'Title English',
                enContent: 'Content English',
                ruTitle: 'Title RU',
                ruContent: 'Content RU',
                date: DateTime.now().add(Duration(minutes: 2)),
              ).toJson();
              String notifyDeadline = Push(
                enTitle: 'Title English',
                enContent: 'Content English',
                ruTitle: 'Title RU',
                ruContent: 'Content RU',
                date: DateTime.now().add(Duration(minutes: 2)),
              ).toJson();
              String notifyTourIsEnd = Push(
                enTitle: 'Title English',
                enContent: 'Content English',
                ruTitle: 'Title RU',
                ruContent: 'Content RU',
                date: DateTime.now().add(Duration(minutes: 2)),
              ).toJson();

              http
                  .post(url, headers: headers, body: notifyNow)
                  .then((value) => print(value.body));
            },
            child: Text('Click'),
          ),
        ],
      ),
    );
  }
}
