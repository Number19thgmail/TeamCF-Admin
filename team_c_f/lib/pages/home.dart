import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/pages/schedule.dart';
import 'package:team_c_f/pages/team.dart';
import 'package:team_c_f/pages/tour.dart';
import 'package:team_c_f/storebloc/blocs/myteam.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:team_c_f/storebloc/states/myteam.dart';
import 'package:team_c_f/storebloc/states/schedule.dart';
import 'package:team_c_f/store/home/home.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:team_c_f/storebloc/states/tour.dart';

class HomePage extends StatelessWidget {
  static Home state = Home();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: context.watch<Data>().downloadSuccessful
          ? MultiBlocProvider(
              providers: [
                BlocProvider<MyTeamBloc>(
                  create: (BuildContext context) => MyTeamBloc(
                    MyTeamState(uid: context.read<Login>().userId),
                  ),
                ),
                BlocProvider<ScheduleBloc>(
                  create: (BuildContext context) => ScheduleBloc(
                    ScheduleState(),
                  ),
                ),
                BlocProvider(
                  create: (BuildContext context) => TourBloc(
                    TourState(
                      round: Data.currentTour.round,
                      uid: context.read<Login>().userId,
                    ),
                  ),
                ),
              ],
              child: Scaffold(
                body: Observer(
                  builder: (_) => SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state.selectedIndex == 0)
                          TeamPage()
                        else if (state.selectedIndex == 1)
                          SchedulePage()
                        else if (state.selectedIndex == 2)
                          TourPage(back: false)
                      ],
                    ),
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
              ),
            )
          : Scaffold(
              body: Text('DOWNLOADING'),
            ),
    );
  }
}
