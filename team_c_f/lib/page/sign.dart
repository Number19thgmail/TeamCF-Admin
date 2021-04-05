import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/data/tournament.dart';
import 'package:team_c_f/servise/auth.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign extends StatefulWidget {
  Sign({Key key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool firstStart = true;
  bool capitan = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  String msg = 'Вход в Google не выполнен';
  String teamSelect;
  List<String> registedTeam = [];

  // @override
  // void initState() {
  //   super.initState();
  //   initPage();
  // }

  @override
  Widget build(BuildContext context) {
    if (firstStart) {
      context.read<Tournament>().initInfo();
      setState(() {
        firstStart = false;
      });
    }
    void register() {
      DatabaseService().checkTeamName(name: teamController.text.trim()).then(
        (value) {
          if (value) {
            DatabaseService().registrationPlayer(
              player: Player(
                name: nameController.text.trim(),
                uid: context.read<Account>().userId,
                capitan: capitan,
                team: capitan ? teamController.text : teamSelect,
                confirmed: capitan ? true : false,
              ),
            );
            if (capitan)
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
              msg: 'Команда с таким именем уже зарегистрирована',
              toastLength: Toast.LENGTH_LONG,
            );
          }
          context.read<Account>().registedUser();
        },
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<Account>().changeSignIn();
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
                    controller: nameController,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
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
                          controller: teamController,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  else
                    context.watch<Tournament>().allTeamNames.isEmpty
                        ? Column(
                            children: [
                              Text('Не зарегистрировано ни одной команды'),
                              Text('Можешь сделать это первым \u261d')
                            ],
                          )
                        : Column(
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: context.watch<Account>().signIn &&
                            (capitan ||
                                (context
                                        .watch<Tournament>()
                                        .allTeamNames
                                        .isNotEmpty &&
                                    teamSelect != null))
                        ? register
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

  // void initPage() {
  //   context.read<Account>().initInfo();
  // }
}
