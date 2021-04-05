import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/auth.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign extends StatefulWidget {
  Sign({Key key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool signIn = false;
  bool capitan = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  String msg = 'Вход в Google не выполнен';
  String userId;
  String teamSelect;
  List<String> registedTeam = [];

  @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    void register() {
      DatabaseService().checkTeamName(name: teamController.text.trim()).then(
        (value) {
          if (value) {
            DatabaseService().registrationPlayer(
              player: Player(
                name: nameController.text.trim(),
                uid: context.read<Account>().getUserId(),
                capitan: capitan,
                team: capitan ? teamController.text : teamSelect,
                confirmed: capitan ? true : false,
              ),
            );
            if (capitan)
              DatabaseService().registrationTeam(
                team: Team(
                  members: [
                    context.read<Account>().getUserId(),
                  ],
                  title: teamController.text.trim(),
                ),
              );
          } else {
            Fluttertoast.showToast(
              msg: 'Команда с таким именем уже зарегистрирована',
              toastLength: Toast.LENGTH_LONG,
            );
          }
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
                signIn ? exitGoogle() : signGoogle();
              },
              child: Text(signIn
                  ? 'Выбрать другой Google-аккаунт'
                  : 'Войти, используя Google-аккаунт'),
            ),
            Text(
              msg,
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
                    Column(
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
                            ...registedTeam
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
                    onPressed: signIn ? register : null,
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

  void exitGoogle() {
    signOutGoogle().then(
      (value) {
        setState(() {
          msg = 'Необходимо войти в аккаунт';
          signIn = false;
        });
        signGoogle();
      },
    );
  }

  void signGoogle() {
    signInWithGoogle().then(
      (value) {
        setState(
          () {
            msg = 'Вход выполнен, осталось совсем чуть чуть';
            signIn = true;
          },
        );
        context.read<Account>().updateSignInfo();
      },
    );
  }

  void initPage() {
    context.read<Account>().updateSignInfo().then(
      (value) {
        setState(() {
          signIn = context.watch<Account>().signIn;
        });
      },
    );
    DatabaseService().getAllTeamNames().then(
      (value) {
        setState(
          () {
            registedTeam = value;
            teamSelect = value.first;
          },
        );
      },
    );
  }
}
