import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/store/selectteam/selectteam.dart';

class SelectTeamView extends StatelessWidget {
  // Класс отображения выбора команды или регистрации новой
  final SelectTeam selectTeam;

  const SelectTeamView({
    Key? key,
    required this.selectTeam,
  }) : super(key: key);

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
                  Observer(
                    builder: (_) => Checkbox(
                      // Чекбокс для капитанов
                      value: selectTeam.capitan,
                      checkColor: Colors.blue,
                      activeColor: Colors.white,
                      onChanged: selectTeam.changeCapitan,
                    ),
                  ),
                  Text(
                    'Я капитан команды',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Observer(
                builder: (_) => Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectTeam.capitan
                            ? 'Введите название вашей команды'
                            : 'Выбери команду',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    selectTeam.capitan
                        ? ListTile(
                            leading: SizedBox(),
                            title: Observer(
                              builder: (_) => TextField(
                                // Ввод названия команды для капитана
                                decoration: InputDecoration(
                                    fillColor: Colors.white, filled: true),
                                onChanged: selectTeam.changeTeam,
                                controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                    text: selectTeam.lastTeamName,
                                    selection: TextSelection.collapsed(
                                        offset: selectTeam.lastTeamName.length),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            trailing: Observer(
                              builder: (_) => selectTeam.enableIcon,
                            ),
                          )
                        : Text('Список команд'),
                  ],
                )
                    // : LoginService().checkTeamName(name: login.teamName) // Проверка существуют ли команды, чтобы в них зарегистрироваться
                    //     ? Column(
                    //         // Для пустого списка
                    //         children: [
                    //           Text(
                    //             'Ни одной доступной команды нет',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //           Text(
                    //             'Можешь создать команду сам \u261d',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //             ),
                    //           )
                    //         ],
                    //       )
                    // : Column(
                    //     // Для непустого списка
                    //     children: [
                    //       Observer(
                    //         builder: (_) => Text(
                    //           login.userName,
                    //           //'Выбери свою команду',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //       // DropdownButton<String>(
                    //       //   value: teamSelect,
                    //       //   onChanged: (newName) {
                    //       //     setState(() {
                    //       //       teamSelect = newName;
                    //       //     });
                    //       //   },
                    //       //   items: [
                    //       //     ...context
                    //       //         .watch<Tournament>()
                    //       //         .allTeamNames
                    //       //         .map<DropdownMenuItem<String>>(
                    //       //           (String team) => DropdownMenuItem(
                    //       //             child: Text(team),
                    //       //             value: team,
                    //       //           ),
                    //       //         )
                    //       //         .toList(),
                    //       //   ],
                    //       // ),
                    //     ],
                    //   ),
                    ),
              ),
            ],
          ),
        ),
        Observer(
          builder: (_) => ElevatedButton(
            // Кнопка регистрации
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: selectTeam.capitan ? 
              selectTeam.registrateTeam // отправить на сервер новую команду
             : null,
            child: Observer(
              builder: (_) => Text(selectTeam.capitan && selectTeam.enableName
                  ? 'Зарегистрировать команду'
                  : ''),
            ),
          ),
        ),
      ],
    );
  }
}
