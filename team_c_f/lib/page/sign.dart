import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign extends StatefulWidget {
  // Класс отображения страницы входа в Google-аккаунт и регистрации в приложении
  Sign({Key key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool capitan = false; // Флаг капитана
  TextEditingController nameController =
      TextEditingController(); // Контроллер для ввода имени участника
  TextEditingController teamController =
      TextEditingController(); // Контроллер для ввода названия команды
  String msg =
      'Вход в Google не выполнен'; // Сообщение о статусе входа в Google-аккаунт
  String teamSelect; // Выбранная команда из списка зарегистрированных
  List<String> registedTeam = []; // Список зарегистрированных команд

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
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        // Чекбокс для капитанов
                        value: capitan,
                        onChanged: (value) {
                          setState(
                            () {
                              capitan = value;
                            },
                          );
                        },
                      ),
                      Text('Я капитан команды'),
                    ],
                  ),
                  if (capitan)
                    Column(
                      children: [
                        Text('Введите название вашей команды'),
                        TextField(
                          // Ввод названия команды для капитана
                          controller: teamController,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else
                    context
                            .watch<Tournament>()
                            .allTeamNames
                            .isEmpty // Проверка существуют ли команды, чтобы в них зарегистрироваться
                        ? Column(
                            // Для пустого списка
                            children: [
                              Text('Не зарегистрировано ни одной команды'),
                              Text('Можешь сделать это первым \u261d')
                            ],
                          )
                        : Column(
                            // Для непустого списка
                            children: [
                              Text('Выбери свою команду'),
                              DropdownButton<String>(
                                value: teamSelect,
                                onChanged: (newName) {
                                  setState(() {
                                    teamSelect = newName;
                                  });
                                },
                                items: [
                                  ...context
                                      .watch<Tournament>()
                                      .allTeamNames
                                      .map<DropdownMenuItem<String>>(
                                        (String team) => DropdownMenuItem(
                                          child: Text(team),
                                          value: team,
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ],
                          ),
                  ElevatedButton(
                    // Кнопка регистрации
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: context
                                .watch<Account>()
                                .signIn && // Проверка входа в Google-аккаунт
                            (capitan || // Проверка или капитан
                                (context
                                        .watch<Tournament>()
                                        .allTeamNames
                                        .isNotEmpty && // или список команд должен быть не пустым
                                    teamSelect !=
                                        null)) // и команда должна быть выбрана
                        ? register // Функция регистрации
                        : null,
                    child: Text(capitan
                        ? 'Зарегистрировать команду'
                        : 'Зарегистрироваться'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register() {
    // Функция регистрации
    DatabaseService().checkTeamName(name: teamController.text.trim()).then(
      // Проверка на уникальное название команды
      (value) {
        if (value) {
          DatabaseService().registrationPlayer(
            // Регистрация игрока
            player: Player(
              name: nameController.text.trim(), // Удаление лишних пробелов
              uid: context
                  .read<Account>()
                  .userId, // Чтение информации о текущем Google-аккаунте
              capitan: capitan,
              team: capitan
                  ? teamController.text
                  : teamSelect, // Название команды
              confirmed:
                  capitan ? true : false, // Подтвержден ли игрок капитаном
            ),
          );
          if (capitan) // Если регистрируется капитан, то необходима регистрация команды
            DatabaseService().registrationTeam(
              team: Team(
                members: [
                  context.read<Account>().userId,
                ],
                points: 0,
                position: 1,
                title: teamController.text.trim(),
              ),
            );
        } else {
          Fluttertoast.showToast(
            // Вывод сообщение о неуникальности названия команды
            msg: 'Команда с таким именем уже зарегистрирована',
            toastLength: Toast.LENGTH_LONG,
          );
        }
        context
            .read<Account>()
            .registedUser(); // Измение информации в классе Account о том, что пользователь зарегистрирован
      },
    );
  }
}
