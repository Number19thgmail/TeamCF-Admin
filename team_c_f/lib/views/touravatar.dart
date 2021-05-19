import 'package:flutter/material.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:team_c_f/storebloc/blocs/schedule.dart';
import 'package:team_c_f/storebloc/blocs/tour.dart' as tourBloc;
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:provider/provider.dart';

class ShowTourAvatar extends StatelessWidget {
  final TourModel tour;
  const ShowTourAvatar({Key? key, required this.tour}) : super(key: key);

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
                ScheduleEvent(
                  event: Event.selectTour,
                  round: tour.stage,
                  uid: context.read<Login>().userId,
                ),
              );
          context.read<tourBloc.TourBloc>().add(
                tourBloc.TourEvent(
                  event: tourBloc.Event.selectTour,
                  stage: tour.stage,
                ),
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