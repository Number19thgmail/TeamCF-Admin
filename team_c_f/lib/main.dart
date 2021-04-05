import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/page/home.dart';
import 'package:team_c_f/page/sign.dart';
import 'package:team_c_f/servise/auth.dart';
import 'package:team_c_f/servise/make.dart';
import 'package:team_c_f/servise/htmlparse.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      // theme: ThemeData(
      //   textTheme: TextTheme(
      //     bodyText2: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.normal,
      //     ),
      //     bodyText1: TextStyle(
      //       color: Colors.black,
      //       decoration: TextDecoration.lineThrough,
      //       fontWeight: FontWeight.normal,
      //     ),
      //     caption: TextStyle(
      //       color: Colors.green,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
      home: ChangeNotifierProvider<Account>(
        create: (context) => Account(),
        child: SafeArea(
          child: Page(),
        ),
      ),
    ),
  );
}

class Page extends StatefulWidget {
  const Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  bool firstStart = true;

  @override
  Widget build(BuildContext context) {
    if (firstStart) {
      context.read<Account>().updateSignInfo();
      setState(() {
        firstStart = false;
      });
    }
    return Container(
      child: context.watch<Account>().signIn
          ? Homepage()
          : Sign(), //Проверка выполнен ли вход в гугл-аккаунт
    );
  }
}

class SelectMatch extends StatefulWidget {
  SelectMatch({Key key}) : super(key: key);

  @override
  _SelectMatchState createState() => _SelectMatchState();
}

class _SelectMatchState extends State<SelectMatch> {
  bool signIn = false;
  User user;
  List<String> range = [];
  List<DateTime> period = [];

  Future<void> download() async {
    range.forEach(
      (date) {
        http.Client()
            .get(Uri.parse('https://www.sports.ru/football/match/$date/'))
            .then((value) {
          context.read<DataShortMatch>().addData([
            ...getMatchs(
              body: value.body,
              date: '$date',
            )
          ]);
        });
      },
    );
  }

  Widget home(int count) {
    return Container(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              range.clear();
              DateRangePicker.showDatePicker(
                context: context,
                initialFirstDate: DateTime.now(),
                initialLastDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2040),
              ).then((value) {
                setState(() {
                  period = value;
                  for (DateTime i = value.first;
                      i.isBefore(value.last.add(Duration(minutes: 1)));
                      i = i.add(Duration(days: 1))) {
                    range.add(DateFormat('yyyy-MM-dd').format(i));
                  }
                });
                context.read<DataShortMatch>().clearData();
                download();
              });
            },
            child: Text('Выбрать даты'),
          ),
          Text(
            '$count/10',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: count > 10 ? Colors.red : Colors.green,
            ),
          ),
          ...makeDays(context.watch<DataShortMatch>().getData),
          ElevatedButton(
              onPressed: () {
                signOutGoogle().then(
                  (value) => setState(() {
                    signIn = false;
                  }),
                );
              },
              child: Text('logout'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? home(context.watch<DataShortMatch>().countSelected)
        : Sign();
  }
}

// class Prob extends StatelessWidget {
//   const Prob({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(
//         '1 - 1',
//         style: Theme.of(context).textTheme.bodyText2,
//       ),
//     );
//   }
// }

// class Content extends StatefulWidget {
//   const Content({Key key}) : super(key: key);

//   @override
//   _ContentState createState() => _ContentState();
// }

// class _ContentState extends State<Content> {
//   Tournament tournament;
//   String currentTour = 'start msg';
//   int matchNumber = 0;
//   Team home;
//   Team away;
//   bool dataDownload = false;

//   Tournament parseTournament(String responseBody) {
//     final parsed = json.decode(responseBody);

//     return Tournament.fromJson(parsed);
//   }

//   Future<Tournament> downloadInfo(http.Client client) async {
//     final response = await client
//         .get(Uri.parse('http://tcfserver.azurewebsites.net/info?tour=31'));

//     return parseTournament(response.body);
//   }

//   changeMatch(int index, CarouselPageChangedReason reason) {
//     setState(() {
//       matchNumber = index;
//       home = tournament.teams
//           .where((element) => element.name == tournament.pair[matchNumber * 2])
//           .first;
//       away = tournament.teams
//           .where(
//               (element) => element.name == tournament.pair[matchNumber * 2 + 1])
//           .first;
//     });
//   }

//   void download() async {
//     downloadInfo(http.Client()).then(
//       (all) => setState(() {
//         currentTour = 'Текущий тур ${all.currentTour}';
//         tournament = all;
//         home = all.teams
//             .where((element) => element.name == all.pair[matchNumber * 2])
//             .first;
//         away = all.teams
//             .where((element) => element.name == all.pair[matchNumber * 2 + 1])
//             .first;
//         dataDownload = true;
//       }),
//     );
//     setState(() {
//       currentTour = 'Загрузка данных';
//     });
//   }

//   Widget headerBuilder(int i) {
//     Team home = tournament.teams
//         .where((element) => element.name == tournament.pair[i * 2])
//         .first;
//     Team away = tournament.teams
//         .where((element) => element.name == tournament.pair[i * 2 + 1])
//         .first;
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.blue[100],
//       ),
//       alignment: Alignment.center,
//       margin: const EdgeInsets.symmetric(
//         vertical: 8,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   '${home.countPerRound}',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   '-',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   '${away.countPerRound}',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Text(
//                     '${home.name.split("\"")[1]}',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Text(
//                     '${away.name.split("\"")[1]}',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget wrap() {
//       return Column(
//         children: [
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             alignment: WrapAlignment.center,
//             direction: Axis.horizontal,
//             children: [
//               for (int i = 0; i < 10; i++)
//                 Meet(
//                   number: i,
//                   home: home,
//                   away: away,
//                   real: tournament.realResults,
//                   rHome: tournament.names.team[i * 2],
//                   rAway: tournament.names.team[i * 2 + 1],
//                   info: tournament.names.info[i],
//                 )
//             ],
//           ),
//         ],
//       );
//     }

//     Widget headers() {
//       return CarouselSlider(
//         items: <Widget>[
//           for (int i = 0; i * 2 < tournament.pair.length; i++) headerBuilder(i)
//         ],
//         options: CarouselOptions(
//           autoPlay: false,
//           enlargeCenterPage: true,
//           onPageChanged: changeMatch,
//           aspectRatio: 4,
//         ),
//       );
//     }

//     return Container(
//       color: Colors.indigo,
//       alignment: Alignment.center,
//       width: double.infinity,
//       height: double.infinity,
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           dataDownload ? headers() : SizedBox(height: 0),
//           Expanded(
//             child: Container(
//               child: ListView(
//                 children: [
//                   dataDownload ? wrap() : Text('Прогнозы ещё не загружены'),
//                   ElevatedButton(
//                     child: Text('Download'),
//                     onPressed: download,
//                   ),
//                   Text(
//                     currentTour,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
