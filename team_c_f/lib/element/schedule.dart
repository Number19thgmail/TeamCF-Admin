import 'package:flutter/material.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/tournament.dart';

class TourView extends StatelessWidget { // Элементы, отвечающие за вид туров при их выборе
  final Tour tour;
  const TourView({Key key, @required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = tour.tour.length < 3
        ? tour.tour
        : tour.tour.length != 12
            ? tour.tour.substring(0, 3)
            : tour.tour.substring(0, 5);
    String subtitle = tour.tour.split(' ').length == 1
        ? ''
        : tour.tour.length != 12
            ? tour.tour.substring(4)
            : tour.tour.substring(6);
    TextStyle styleTitle = tour.tour.length != 12
        ? Theme.of(context).textTheme.headline5
        : Theme.of(context).textTheme.headline6;
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.read<Tournament>().select(tour.tour);
        },
        child: CircleAvatar(
          backgroundColor: tour.show ? Colors.green : Colors.grey,
          radius: 40,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: styleTitle,
              ),
              tour.tour.split(' ').length != 1
                  ? Text(
                      subtitle,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
