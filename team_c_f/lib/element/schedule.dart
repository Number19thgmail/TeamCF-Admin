import 'package:flutter/material.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';

class TourView extends StatelessWidget {
  final Tour tour;
  const TourView({Key key, @required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.read<Tournament>().select(tour.tour);
        },
        child: CircleAvatar(
          backgroundColor: tour.show ? Colors.green : Colors.grey,
          radius: 35,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tour.tour,
                style: Theme.of(context).textTheme.headline5,
              ),
              tour.tour.split(' ').length != 1
                  ? Text(
                      tour.tour.substring(4),
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : SizedBox(),
            ],
          ),
          //Text(tour.show ? 'Посмотреть тур' : 'Прогнозы недоступны'),
        ),
      ),
    );
  }
}
