import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/servise/make.dart';

class ScheduleView extends StatefulWidget {
  // Класс, отображающий результаты тура, по умолчанию текущего
  const ScheduleView({Key key}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  TextEditingController circle = TextEditingController();
  List<Tour> timetable = [];

  @override
  Widget build(BuildContext context) {
    int registTeam = 16; //context.watch<Tournament>().allTeams.length;
    int fullTeam = context
        .read<Tournament>()
        .allTeams
        .where((team) => team.members.length == 3)
        .length;
    return Container(
      child: Card(
        child: ListTile(
          title: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  showRegisterTeam(registTeam) + ' ' + showTeam(registTeam),
                ),
                SizedBox(height: 20),
                Text(
                  showFullTeam(fullTeam) + ' ' + showTeam(fullTeam),
                ),
                SizedBox(height: 20),
                Text('Укажите количество кругов в чемпионате'),
                TextField(
                  controller: circle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Ожидается ' +
                      showMatches(
                        teams: registTeam,
                        circles: 2,
                      ),
                ),
                SizedBox(height: 20),
                Text(
                  'Ожидается ' +
                      showTours(
                        teams: registTeam,
                        circles: 2,
                      ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: createTimetable,
                  child: Text(
                    'Создать расписание',
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...timetable.map(
                        (tour) {
                          String str = '';
                          tour.pair.forEach(
                            (pair) {
                              str += pair + ' \b';
                            },
                          );
                          return Text(tour.tour + ' тур. Играют $str');
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //Text('Выбираем тур и показываем его результаты или календарь'),
    );
  }

  void createTimetable() {
    List<String> teams = [
      '1',
      '2',
      '3',
    ]; //context.read<Tournament>().allTeamNames;
    List<Tour> curr = [];
    int circles = 2; //int.parse(circle.text);
    int count = teams.length;
    int tour = (count.isEven ? count - 1 : count);
    for (int q = 0; q < circles; q++) {
      for (int i = 0; i < tour; i++) {
        List<String> pair = [];
        for (int j = 0; j < count ~/ 2; j++) {
          int k = count.isEven ? j : j + 1;
          int home = i.isOdd
              ? k == 0
                  ? count - 1
                  : (count ~/ 2 + i ~/ 2 + k + (count.isEven ? 0 : 1)) %
                      (count.isOdd ? count : count - 1)
              : k + i ~/ 2;
          int away = i.isOdd
              ? count ~/ 2 + i ~/ 2 - j
              : k == 0
                  ? count - 1
                  : (count + i ~/ 2 - 1 - k + (count.isEven ? 0 : 1)) %
                      (count.isOdd ? count : count - 1);
          String element = q.isEven
              ? teams[home] + ' - ' + teams[away]
              : teams[away] + ' - ' + teams[home];
          pair.add(element);
        }
        curr.add(Tour.basic(tour: (i + 1 + q * tour).toString(), pair: pair));
      }
    }
    setState(() {
      timetable = curr;
    });
  }
}
