import 'package:flutter/material.dart';
import 'package:team_c_f/components/login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoginView(),
      ),
    );
  }
}
