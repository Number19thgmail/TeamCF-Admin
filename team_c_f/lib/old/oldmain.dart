import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:team_c_f/data/data.dart';
// import 'package:team_c_f/data/shortmatch.dart';
// import 'package:team_c_f/data/tournament.dart';
// import 'package:team_c_f/page/home.dart';
// import 'package:team_c_f/page/sign.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  myApp();
}

myApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase

  OneSignal.shared.setAppId('93b27d54-e442-4af5-86e4-a215faf20e3a');
  
  runApp(
    MultiProvider(
      // Мультипровайдер, для упроощения взаимодействия с данными
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => Account(),
        // ), // Данные связанные с аутентификацией (гугл-вход и регистрация в приложении)
        // ChangeNotifierProvider(
        //   create: (context) => Tournament(),
        // ), // Данные полученные из Firebase
        // ChangeNotifierProvider(
        //   create: (context) => DataMatch(),
        // ),
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
  const Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: context
      //         .watch<Account>()
      //         .registedInApp // Проверка зарегистрирован ли пользователь в приложении
      //     ? Homepage() // Домашняя страница приложения
      //     : Sign(), // Регистрация в приложении + вход в гугл
    );
  }
}