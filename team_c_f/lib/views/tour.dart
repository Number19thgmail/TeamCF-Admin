import 'package:flutter/material.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:provider/provider.dart';

class ShowTour extends StatelessWidget {
  final TourModel tour;
  const ShowTour({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          context.read<ScheduleBloc>().add(
                ScheduleEvent(event: Event.selectTour, stage: tour.name),
              );
        },
        child: CircleAvatar(
            radius: MediaQuery.of(context).size.width / 10,
            child: Text(
              tour.name,
              maxLines: 3,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
            )),
      ),
    );
  }
}
