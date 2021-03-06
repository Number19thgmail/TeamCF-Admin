import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/element/tour.dart';
import 'package:team_c_f/view/emptyschedule.dart';
import 'package:team_c_f/view/scorers.dart';
import 'package:team_c_f/view/table.dart';
import 'package:team_c_f/view/team.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/data/data.dart';

class Homepage extends StatefulWidget {
  // Класс отображающий домашнюю страницу с баром снизу
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedPage = 2;

  @override
  void initState() {
    super.initState();
    context
        .read<Tournament>()
        .initMeAndMyTeam(uid: context.read<Account>().userId);
  }

  @override
  Widget build(BuildContext context) {
    //bool matchSelecting = context.watch<DataShortMatch>().matchSelecting;
    CurrentTour current = context.watch<Tournament>().current;
    return Scaffold(
      // Логика отображения страниц в соответствии с выбранным элементом бара
      body: selectedPage > 2
          ? selectedPage == 4
              ? ShowScorers()
              : ShowTable()
          : selectedPage > 0
              ? selectedPage == 2
                  ? ShowTour(tour: current != null ? current.tour : null)
                  : ScheduleView()
              : TeamView(),
      bottomNavigationBar: CustomNavigationBar(
        // Бар с вариантами выбора страниц
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
          CustomNavigationBarItem(
            icon: Icon(Icons.toc),
            title: Text(
              'Таблица',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.list_alt),
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
