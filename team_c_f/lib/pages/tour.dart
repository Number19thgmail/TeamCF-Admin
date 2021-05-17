import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/pages/selectmeets.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart' as schedule;
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/states/tour.dart';
import 'package:team_c_f/views/meets.dart';
import 'package:team_c_f/views/tour.dart';

class TourPage extends StatelessWidget {
  final bool back;
  const TourPage({Key? key, required this.back}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TourBloc bloc = back
        ? context.watch<schedule.ScheduleBloc>().state.tourBloc!
        : context.watch<TourBloc>();
    return BlocBuilder<TourBloc, TourState>(
      bloc: bloc,
      builder: (context, state) => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (back)
                TextButton(
                  onPressed: () {
                    context.read<schedule.ScheduleBloc>().add(
                          schedule.ScheduleEvent(
                              event: schedule.Event.unselectTour),
                        );
                  },
                  child: Text('Назад'),
                ),
              state.meets.meets.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowMeets(
                            meetsModel: state.meets,
                          ),
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text('Оставить прогноз'),
                        ),
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute<TourEvent?>(
                            builder: (context) =>
                                SelectMeetsPage(round: bloc.state.round),
                          ),
                        )
                            .then(
                          (TourEvent? event) {
                            if (event != null) bloc.add(event);
                          },
                        );
                      },
                      child: Text('Выбрать матчи'),
                    ),
              ShowTour(tour: state.tour),
            ],
          ),
        ),
      ),
    );
  }
}
