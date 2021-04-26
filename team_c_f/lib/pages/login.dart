import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/components/login.dart';
import 'package:team_c_f/store/login/login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<Login>(create: (_) => Login()),
        ],
        child: SafeArea(
          child: Scaffold(
            body: LoginView(),
          ),
        ),
      ),
    );
  }
}