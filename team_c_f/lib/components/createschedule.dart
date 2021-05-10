import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_c_f/servises/servises.dart';
import 'package:team_c_f/storebloc/blocs/createschedule.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';

class CreateScheduleView extends StatelessWidget {
  const CreateScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateScheduleBloc bloc = context.watch<CreateScheduleBloc>();
    return Container(
      child: Card(
        child: ListTile(
          title: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  showRegisterTeam(bloc.state.registTeam) +
                      ' ' +
                      showTeam(bloc.state.registTeam),
                ),
                SizedBox(height: 20),
                Text(
                  showFullTeam(bloc.state.fullTeam) +
                      ' ' +
                      showTeam(bloc.state.fullTeam),
                ),
                SizedBox(height: 20),
                Text('Укажите количество кругов в чемпионате'),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (circle) {
                    circle.trim();
                    bloc.state.circle = circle != '' ? int.parse(circle) : 1;
                    bloc.add(CreateScheduleEvent.changeCircle);
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Ожидается ' +
                      showMatches(
                        matches: bloc.state.matches,
                      ) +
                      ' в каждом туре',
                ),
                SizedBox(height: 20),
                Text(
                  'Ожидается ' +
                      showTours(
                        tours: bloc.state.tours,
                      ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(CreateScheduleEvent.createSchedule);
                    context.read<ScheduleBloc>().add(ScheduleEvent.createSuccessful);
                  },
                  child: Text(
                    'Создать расписание',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
