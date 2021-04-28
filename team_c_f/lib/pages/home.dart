import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/servises/data.dart';
import 'package:team_c_f/store/login/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataService().initData();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Data.tours != null
                ? Data.tours!.isNotEmpty
                    ? Text(Data.tours![0].round)
                    : Text('Туров нет')
                : Text('Идёт загрузка'),
            ElevatedButton(
                onPressed: Provider.of<Login>(context).googleLogout,
                child: Text(
                  'logout',
                )),
          ],
        ),
      ),
    );
  }
}
