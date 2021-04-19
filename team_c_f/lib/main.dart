import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/page/home.dart';
import 'package:team_c_f/page/sign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  MyApp();
}

MyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase

  //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init('93b27d54-e442-4af5-86e4-a215faf20e3a', iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(
    MultiProvider(
      // Мультипровайдер, для упроощения взаимодействия с данными
      providers: [
        ChangeNotifierProvider(
          create: (context) => Account(),
        ), // Данные связанные с аутентификацией (гугл-вход и регистрация в приложении)
        ChangeNotifierProvider(
          create: (context) => Tournament(),
        ), // Данные полученные из Firebase
        ChangeNotifierProvider(
          create: (context) => DataMatch(),
        ),
      ],
      child: MaterialApp(
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
        home: SafeArea(
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: context
              .watch<Account>()
              .registedInApp // Проверка зарегистрирован ли пользователь в приложении
          ? Homepage() // Домашняя страница приложения
          : Sign(), // Регистрация в приложении + вход в гугл
    );
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
