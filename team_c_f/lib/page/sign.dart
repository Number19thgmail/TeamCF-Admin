import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/element/selectTeam.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign extends StatefulWidget {
  // Класс отображения страницы входа в Google-аккаунт и регистрации в приложении
  Sign({Key key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController nameController =
      TextEditingController(); // Контроллер для ввода имени участника

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<Account>()
                    .changeSignIn(); // Изменение состояния входа в Google-аккаунт
              },
              child: Text(context.watch<Account>().signIn
                  ? 'Выбрать другой Google-аккаунт'
                  : 'Войти, используя Google-аккаунт'),
            ),
            Text(
              context.watch<Account>().signIn
                  ? 'Вход выполнен, осталось совсем чуть чуть'
                  : 'Необходимо войти в аккаунт',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Column(
                children: [
                  Text('Введите ваше имя и фамилию'),
                  TextField(
                    // Ввод имени участника
                    controller: nameController,
                    onChanged: (str) {
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                  ),
                  SelectTeam(
                    message: 'Зарегистрироваться',
                    name:
                        nameController.text.trim(), //! Узнать передаётся ли имя
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
