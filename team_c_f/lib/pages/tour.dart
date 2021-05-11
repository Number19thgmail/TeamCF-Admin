import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';

class TourPage extends StatelessWidget {
  final bool back;
  const TourPage({Key? key, required this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (back)
          TextButton(
            onPressed: () {
              context.read<ScheduleBloc>().add(
                    ScheduleEvent(event: Event.unselectTour),
                  );
            },
            child: Text('Назад'),
          ),
        Container(
          child: Text('Show tour'),
        ),
      ],
    );
  }
}
