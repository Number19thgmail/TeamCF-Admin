import 'dart:math';

import 'package:flutter/material.dart';
import 'package:team_c_f/servise/auth.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text('Создать 1 тур'),
        onPressed: () {
          signOutGoogle();
          context.read<Account>().updateSignInfo();
          // DatabaseService().updateCurrentTour()
        },
      ), //Text('Выбираем тур и показываем его результаты или календарь'),
    );
  }
}
