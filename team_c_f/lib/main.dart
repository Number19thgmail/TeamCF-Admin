import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:team_c_f/pages/login.dart';

Future<void> main() async {
  myApp();
}

myApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase

  OneSignal.shared.setAppId('93b27d54-e442-4af5-86e4-a215faf20e3a');

  runApp(LoginPage());
}
