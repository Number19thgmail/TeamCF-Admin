import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/servise/operationdb.dart';

class SelectTeam extends StatefulWidget {
  // Класс отображения выбора команды или регистрации новой
  final String message;
  final String name;
  SelectTeam({Key key, @required this.message, this.name}) : super(key: key);

  @override
  _SelectTeamState createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  TextEditingController teamController = TextEditingController();
  String teamSelect;
  bool capitan = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    // Чекбокс для капитанов
                    value: capitan,
                    checkColor: Colors.blue,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(
                        () {
                          capitan = value;
                        },
                      );
                    },
                  ),
                  Text(
                    'Я капитан команды',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                child: capitan
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Введите название вашей команды',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextField(
                            // Ввод названия команды для капитана
                            decoration: InputDecoration(
                                fillColor: Colors.white, filled: true),
                            controller: teamController,
                            onChanged: (name) {
                              setState(() {});
                            },
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : context
                            .watch<Tournament>()
                            .allTeamNames
                            .isEmpty // Проверка существуют ли команды, чтобы в них зарегистрироваться
                        ? Column(
                            // Для пустого списка
                            children: [
                              Text(
                                'Ни одной доступной команды нет',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Можешь создать команду сам \u261d',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : Column(
                            // Для непустого списка
                            children: [
                              Text(
                                'Выбери свою команду',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
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
              ),
            ],
          ),
        ),
        ElevatedButton(
          // Кнопка регистрации
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: context
                      .watch<Account>()
                      .signIn && // Проверка входа в Google-аккаунт
                  ((capitan && // Проверка для капитана
                          teamController.text
                              .trim()
                              .isNotEmpty) || // Проверка пустое ли название команды
                      (!capitan && // Проверки для некапитанов
                          context
                              .watch<Tournament>()
                              .allTeamNames
                              .isNotEmpty && // или список команд должен быть не пустым
                          teamSelect != null)) // и команда должна быть выбрана
              ? () async {
                  if (capitan &&
                      !(await DatabaseService().checkTeamName(
                          // Проверка уникальности имени команды
                          name: teamController.text.trim()))) {
                    Fluttertoast.showToast(
                      msg: 'Команда с таким названием уже зарегистрирована',
                      toastLength: Toast.LENGTH_LONG,
                    );
                  } else {
                    context
                        .read<Tournament>()
                        .registrationPlayer(
                          // Регистрация игрока
                          uid: context.read<Account>().userId,
                          capitan: capitan,
                          name: widget.name,
                          team:
                              capitan ? teamController.text.trim() : teamSelect,
                        )
                        .then((value) => context.read<Account>().registedUser())
                        .then((value) {
                      if (capitan) // Если капитан, то необходимо зарегистрировать команду
                        context // Регистрация команды
                            .read<Tournament>()
                            .registrationTeam(
                                title: teamController.text.trim());
                      context
                          .read<Tournament>()
                          .initMeAndMyTeam(uid: context.read<Account>().userId);
                    });
                  }
                } // Функция регистрации
              : null,
          child: Text(capitan ? 'Зарегистрировать команду' : widget.message),
        ),
      ],
    );
  }
}
