import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/store/login/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Домашний экран'),
            ElevatedButton(
                onPressed: Provider.of<Login>(context).googleLogout,
                child: Text(
                  'logout',
                )),
          ],
        ),
      ),
    );
  }
}
