import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/components/login.dart';
import 'package:team_c_f/data/singledata/login.dart';

Future<void> main() async {
  myApp();
}

myApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase

  OneSignal.shared.init('93b27d54-e442-4af5-86e4-a215faf20e3a', iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => DataLogin(),
        child: SafeArea(
          child: Scaffold(
            body: LoginView(),
          ),
        ),
      ),
    );
  }
}