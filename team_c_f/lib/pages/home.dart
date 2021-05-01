import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/servises/data.dart';
import 'package:team_c_f/store/home/home.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatelessWidget {
  static Home state = Home();
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
        bottomNavigationBar: Observer(
          builder: (_) => BottomNavyBar(
            // Бар с вариантами выбора страниц
            onItemSelected: state.selectIndex,
            selectedIndex: state.selectedIndex,
            iconSize: 20.0,
            items: <BottomNavyBarItem> [
              BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Column(
                  children: [
                    Text(
                      'Моя',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      'команда',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text(
                  'Календарь',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.add_to_photos),
                title: Column(
                  children: [
                    Text(
                      'Текущий',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      'тур',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.toc),
                title: Text(
                  'Таблица',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.list_alt),
                title: Text(
                  'Бомбардиры',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
