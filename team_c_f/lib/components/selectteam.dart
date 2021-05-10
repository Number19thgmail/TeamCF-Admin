import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/storebloc/blocs/myteam.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:team_c_f/store/selectteam/selectteam.dart';

class SelectTeamView extends StatelessWidget {
  // Класс отображения выбора команды или регистрации новой
  final SelectTeam selectTeam;
  final bool updateMyTeam;

  const SelectTeamView({
    Key? key,
    required this.selectTeam,
    required this.updateMyTeam,
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
                          ? Observer(
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
                            )
                          : Observer(
                              builder: (_) => selectTeam.allTeamNames.isNotEmpty
                                  ? DropdownButton<String>(
                                      value: selectTeam.selectedTeam,
                                      onChanged: selectTeam.selestTeam,
                                      items: [
                                        ...selectTeam.allTeamNames
                                            .map<DropdownMenuItem<String>>(
                                              (String team) => DropdownMenuItem(
                                                child: Text(team),
                                                value: team,
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
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
                                      ),
                                    ),
                            ),
                    ],
                  ),
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
            onPressed: selectTeam.uName.isNotEmpty
                ? selectTeam.capitan
                    ? selectTeam.teamName.isNotEmpty
                        ? selectTeam.enableName
                            ? () {
                                selectTeam.registrateTeam().then(
                                  (_) {
                                    context.read<Login>().validateInApp();
                                    context.read<Data>().clearData();
                                    if (updateMyTeam)
                                      context
                                          .read<MyTeamBloc>()
                                          .add(MyTeamEvent.reset);
                                  },
                                );
                              }
                            : null
                        : null
                    : selectTeam.selectedTeam != null
                        ? () {
                            selectTeam.assertTeam().then(
                              (_) {
                                context.read<Login>().validateInApp();
                                context.read<Data>().clearData();
                                if (updateMyTeam)
                                  context
                                      .read<MyTeamBloc>()
                                      .add(MyTeamEvent.reset);
                              },
                            );
                          }
                        : null
                : null,
            child: Observer(
              builder: (_) => Text(selectTeam.uId.isNotEmpty
                  ? selectTeam.uName.isNotEmpty
                      ? selectTeam.capitan
                          ? selectTeam.teamName.isNotEmpty
                              ? selectTeam.enableName
                                  ? 'Зарегистрировать команду'
                                  : 'Данное название команды недоступно'
                              : 'Введите название команды'
                          : selectTeam.selectedTeam != null
                              ? selectTeam.regButtonText
                              : 'Выберите команду'
                      : 'Введите имя и фамилию'
                  : 'Необходимо войти в Google-аккаунт'),
            ),
          ),
        ),
      ],
    );
  }
}
