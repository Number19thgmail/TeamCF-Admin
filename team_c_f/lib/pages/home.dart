import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/pages/team.dart';
import 'package:team_c_f/servises/data.dart';
import 'package:team_c_f/store/home/home.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatelessWidget {
  static Home state = Home();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: context.watch<Data>().downloadSuccessful
          ? Scaffold(
              body: Observer(
                builder: (_) => Column(
                  children: [
                    if (state.selectedIndex == 0) TeamPage(),
                    Data.tours.isNotEmpty
                        ? Text(Data.tours[0].round)
                        : Text('Туров нет'),
                    ElevatedButton(
                      onPressed: Provider.of<Login>(context).googleLogout,
                      child: Text(
                        '${state.selectedIndex}',
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Observer(
                builder: (_) => BottomNavyBar(
                  // Бар с вариантами выбора страниц
                  onItemSelected: state.selectIndex,
                  selectedIndex: state.selectedIndex,
                  iconSize: 20.0,
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                      icon: Icon(Icons.people),
                      title: Text(
                        'Моя команда',
                        style: Theme.of(context).textTheme.caption,
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
                      title: Text(
                        'Текущий тур',
                        style: Theme.of(context).textTheme.caption,
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
            )
          : Scaffold(
              body: Text('DOWNLOADING'),
            ),
    );
  }
}
