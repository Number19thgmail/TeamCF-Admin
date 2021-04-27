import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/pages/login.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:team_c_f/pages/home.dart';

Future<void> main() async {
  myApp();
}

myApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase

  OneSignal.shared.setAppId('93b27d54-e442-4af5-86e4-a215faf20e3a');

  runApp(
    MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<Login>(create: (_) => Login()),
        ],
        child: FirstPage(),
      ),
    ),
  );
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Provider.of<Login>(context).registrateInApp
            ? HomePage()
            : LoginPage());
  }
}
