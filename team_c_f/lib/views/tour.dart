import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class ShowTour extends StatelessWidget {
  final TourModel tour;
  const ShowTour({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Table(
        border: TableBorder(
          top: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
          right: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
          bottom: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
          left: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
          horizontalInside: BorderSide(
            width: 2,
            color: Colors.amber,
          ),
        ),
        columnWidths: {
          0: FixedColumnWidth(size / 2.5),
          1: FixedColumnWidth(size / 8),
          2: FixedColumnWidth(size / 2.5),
        },
        children: [
          ...tour.result.map(
            (List<Map<String, int?>> match) {
              String home = match.first.values.single != null
                  ? match.first.values.single.toString()
                  : '';
              String away = match.last.values.single != null
                  ? match.last.values.single.toString()
                  : '';
              return TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        match.first.keys.single,
                        textAlign: TextAlign.center,
                      ),
                      color: tour.result.indexOf(match).isEven
                          ? Colors.cyan[100]
                          : Colors.cyan[400],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        home + ':' + away,
                        textAlign: TextAlign.center,
                      ),
                      color: tour.result.indexOf(match).isEven
                          ? Colors.cyan[100]
                          : Colors.cyan[400],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        match.last.keys.single,
                        textAlign: TextAlign.center,
                      ),
                      color: tour.result.indexOf(match).isEven
                          ? Colors.cyan[100]
                          : Colors.cyan[400],
                    ),
                  ],
              );
            },
          ),
        ],
      ),
    );
  }
}
