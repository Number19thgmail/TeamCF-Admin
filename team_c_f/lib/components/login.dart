import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/components/selectteam.dart';
import 'package:team_c_f/data/singledata/login.dart';
import 'package:team_c_f/store/login/login.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Login login = Provider.of<Login>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (_) => ElevatedButton(
              onPressed: () {
                login.updatedLoginStatus
                    ? login.googleLogout()
                    : login.googleLogin();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    login.updatedLoginStatus ? 'Выйти' : 'Войти',
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: AssetImage('assets/images/google.png'),
                    fit: BoxFit.fill,
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) => Text(
              login.updatedLoginStatus
                  ? 'Вход выполнен, осталось совсем чуть чуть'
                  : 'Необходимо войти в аккаунт',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Введите ваше имя и фамилию',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  // Ввод имени участника
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: login.changeName,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) => SelectTeamView(
              selectTeam: Provider.of<Login>(context).selectTeam,
              name: '',
            ),
          ),
        ],
      ),
    );
  }
}
