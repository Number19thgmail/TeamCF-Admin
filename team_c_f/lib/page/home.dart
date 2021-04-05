import 'package:flutter/material.dart';
import 'package:team_c_f/element/forecast.dart';
import 'package:team_c_f/element/schedule.dart';
import 'package:team_c_f/element/scorers.dart';
import 'package:team_c_f/element/table.dart';
import 'package:team_c_f/element/team.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedPage = 2;

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: selectedPage > 2
            ? selectedPage == 4
                ? ShowScorers()
                : ShowTable()
            : selectedPage > 0
                ? selectedPage == 2
                    ? MakeForecast()
                    : ScheduleView()
                : TeamView(),
        bottomNavigationBar: CustomNavigationBar(
          onTap: (i) {
            setState(() {
              selectedPage = i;
            });
          },
          currentIndex: selectedPage,
          iconSize: 20.0,
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text(
                'Моя команда',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text(
                'Календарь',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.add_to_photos),
              title: Column(
                children: [
                  Text(
                    'Оставить',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    'прогноз',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.toc),
              title: Text(
                'Таблица',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.agriculture),
              title: Text(
                'Бомбардиры',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
    );
  }
}
