import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/components/unconfirmedplayer.dart';
import 'package:team_c_f/components/selectteam.dart';
import 'package:team_c_f/storebloc/blocs/myteam.dart';
import 'package:team_c_f/storebloc/states/myteam.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/views/team.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyTeamBloc bloc = context.watch<MyTeamBloc>();
    context.read<Login>().changeName(bloc.state.name);
    context.read<Login>().setDataToSelectTeam(buttonText: 'Выбрать команду');
    return BlocBuilder<MyTeamBloc, MyTeamState>(
      bloc: bloc,
      builder: (context, state) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      // Показывает место в таблице бомбардиров
                      backgroundColor: Colors.blue[100],
                      child: Text(bloc.state.position),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(bloc.state.name), // Показывает имя участника
                      ],
                    ),
                    subtitle: bloc.state.team != 'Нет команды'
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.done,
                                  color: bloc.state.confirmed
                                      ? Colors.green
                                      : Colors.grey),
                              Text(bloc.state.team),
                            ],
                          )
                        : Text(
                            'Нет команды',
                            textAlign: TextAlign.center,
                          ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            context.read<Login>().googleLogout();
                          }),
                    ),
                  ),
                ),
                if (bloc.state.team == 'Нет команды')
                  SelectTeamView(
                    selectTeam: context.read<Login>().selectTeam,
                    updateMyTeam: true,
                  ),
              ],
            ),
          ),
          if (bloc.state.capitan &&
              bloc.state.unconfirm
                  .isNotEmpty) // Отображение для капитана списка игроков, которые зарегистрировались, но ещё не получили подтверждение в его команде
            ...bloc.state.unconfirm.map(
              (p) => UnconfirmedPlayerView(player: p),
            ),
          if (bloc.state.teamData != null)
            ShowTeam(
              // Показ информации о моей команде
              team: bloc.state.teamData!,
            ),
        ],
      ),
    );
  }
}
