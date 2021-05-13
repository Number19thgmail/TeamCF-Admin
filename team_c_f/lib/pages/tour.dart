import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart' as schedule;
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/states/tour.dart';

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
      builder: (context, state) => Center(
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
            state.meets != null
                ? Text('Show meets')
                : TextButton(
                    onPressed: (){},
                    child: Text('Выбрать матчи'),
                  ),
          ],
        ),
      ),
    );
  }
}
