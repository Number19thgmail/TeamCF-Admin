import 'package:flutter/material.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:provider/provider.dart';

class ShowTour extends StatelessWidget {
  final TourModel tour;
  const ShowTour({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    double fontSize;
    if (tour.name.split(' ').length > 1) {
      title =
          tour.name.split(' ')[0] + '\n' + tour.name.split(' ')[1] + ' матч';
      fontSize = MediaQuery.of(context).size.width / 20;
    } else {
      title = tour.name;
      fontSize = MediaQuery.of(context).size.width / 15;
    }
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
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: fontSize),
            )),
      ),
    );
  }
}
