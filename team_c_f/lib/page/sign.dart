import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/element/selectTeam.dart';

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
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<Account>()
                    .changeSignIn(); // Изменение состояния входа в Google-аккаунт
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.watch<Account>().signIn ? 'Выйти' : 'Войти'),
                  SizedBox(width: 10),
                  Image(
                      image: AssetImage('assets/images/google.png'),
                      fit: BoxFit.fill,
                      height: 30,
                    ),
                ],
              ),
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
                    decoration:
                        InputDecoration(fillColor: Colors.white, filled: true),
                    // Ввод имени участника
                    controller: nameController,
                    onChanged: (str) {
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SelectTeam(
              message: 'Зарегистрироваться',
              name: nameController.text.trim(),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
