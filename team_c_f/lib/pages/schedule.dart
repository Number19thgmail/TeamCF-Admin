import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/components/createschedule.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/blocs/createschedule.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';
import 'package:team_c_f/storebloc/components/createschedule.dart';
import 'package:team_c_f/storebloc/components/schedule.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/views/tour.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScheduleBloc bloc = context.watch<ScheduleBloc>();
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: bloc,
      builder: (context, state) => state.enableSchedule
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.amber,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  ...bloc.state.tours.map(
                    (TourModel tour) => ShowTour(tour: tour),
                  ),
                ],
              ),
            )
          : BlocProvider(
              create: (context) => CreateScheduleBloc(
                    CreateScheduleState(),
                  ),
              child: CreateScheduleView()),
    );
  }
}
