import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/components/createschedule.dart';
import 'package:team_c_f/components/unconfirmedplayer.dart';
import 'package:team_c_f/components/selectteam.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/store/bloc/createschedule.dart';
import 'package:team_c_f/store/bloc/myteam.dart';
import 'package:team_c_f/store/bloc/schedule.dart';
import 'package:team_c_f/store/components/createschedule.dart';
import 'package:team_c_f/store/components/myteam.dart';
import 'package:team_c_f/store/components/schedule.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/views/team.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScheduleBloc bloc = context.watch<ScheduleBloc>();
    // context.read<Login>().changeName(bloc.state.name);
    // context.read<Login>().setDataToSelectTeam(buttonText: 'Выбрать команду');
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: bloc,
      builder: (context, state) => state.enableSchedule
          ? Column(
              children: [
                ...Data.tours.map((TourData tour) => )
              ],
            )
          : BlocProvider(
              create: (context) => CreateScheduleBloc(
                    CreateScheduleState(),
                  ),
              child: CreateScheduleView()),
    );
  }
}
