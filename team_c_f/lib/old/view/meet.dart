// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:team_c_f/data/forecast.dart';
// import 'package:team_c_f/data/team.dart';

// class Meet extends StatefulWidget {
//   final int number;
//   final Team home;
//   final Team away;
//   final Forecast real;
//   final String rHome;
//   final String rAway;
//   final String info;
//   const Meet({
//     Key key,
//     @required this.number,
//     @required this.home,
//     @required this.away,
//     @required this.real,
//     @required this.rHome,
//     @required this.rAway,
//     @required this.info,
//   }) : super(key: key);

//   @override
//   _MeetState createState() => _MeetState();
// }

// class _MeetState extends State<Meet> {
//   bool currentView = false;
//   @override
//   Widget build(BuildContext context) {
//     double heigthMatch = currentView         ? (MediaQuery.of(context).size.width - 100) / 2
//         : (MediaQuery.of(context).size.width + 100) / 2;
//     void makeToast() {
//       // Fluttertoast.showToast(
//       //     msg: 'Ширина экрана: $widthScreen',
//       //     toastLength: Toast.LENGTH_SHORT,
//       //     gravity: ToastGravity.BOTTOM,
//       //     timeInSecForIosWeb: 1,
//       //     backgroundColor: Colors.red,
//       //     textColor: Colors.white,
//       //     fontSize: 16.0);
//       setState(() {
//         currentView = !currentView;
//       });
//     }

//     var minimalizeMatch = [
//       realStatus(context),
//       Text(
//         '${widget.rHome}',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: MediaQuery.of(context).size.width / 20,
//         ),
//       ),
//       SizedBox(width: 5),
//       realScore(context),
//       Text(
//         '${widget.rAway}',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: MediaQuery.of(context).size.width / 20,
//         ),
//       ),
//     ];
//     var maximalizeMatch = [
//       realStatus(context),
//       Text(
//         '${widget.rHome}',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: MediaQuery.of(context).size.width / 30,
//         ),
//       ),
//       SizedBox(width: 5),
//       realScore(context),
//       Text(
//         '${widget.rAway}',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: MediaQuery.of(context).size.width / 30,
//         ),
//       ),
//       Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Column(children: [...showForecastTeam(context, widget.home)]),
//           SizedBox(width: 15),
//           Column(children: [...showForecastTeam(context, widget.away)]),
//         ],
//       ),
//     ];
//     return OutlineButton(
//       padding: const EdgeInsets.all(0),
//       onPressed: makeToast,
//       color: Colors.pink,
//       child: AnimatedContainer(
//         height: heigthMatch,
//         duration: const Duration(milliseconds: 1000),
//         width: (MediaQuery.of(context).size.width - 100) / 2,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.green, width: 3),
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.blue[200],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: currentView ? minimalizeMatch : maximalizeMatch,
//         ),
//       ),
//     );
//   }

//   List<Widget> showForecastTeam(BuildContext context, Team team) {
//     return team.players
//         .map(
//           (element) => Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 3,
//               horizontal: 2,
//             ),
//             margin: const EdgeInsets.only(
//               bottom: 1,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: element.forecast.point[widget.number] == 3                   ? Colors.green[700]
//                   : (element.forecast.point[widget.number] == 2                       ? Colors.yellowAccent[400]
//                       : (element.forecast.point[widget.number] == 1                           ? Colors.amber[700]
//                           : Colors.transparent)),
//             ),
//             child: Text(
//               '${element.forecast.rate[widget.number * 2]} - ${element.forecast.rate[widget.number * 2 + 1]}',
//               style: (element.forecast.point[widget.number] == 0 &&
//                       widget.real.rate[widget.number * 2] != -1)                   ? Theme.of(context).textTheme.bodyText1.copyWith(
//                         fontSize: MediaQuery.of(context).size.width / 22,
//                       )
//                   : Theme.of(context).textTheme.bodyText2.copyWith(
//                         fontSize: MediaQuery.of(context).size.width / 22,
//                       ),
//             ),
//           ),
//         )
//         .toList();
//   }

//   Text realScore(BuildContext context) {
//     return Text(
//       widget.real.rate[widget.number * 2] == -1           ? ''
//           : '${widget.real.rate[widget.number * 2]} - ${widget.real.rate[widget.number * 2 + 1]}',
//       style: Theme.of(context).textTheme.caption.copyWith(
//             fontSize: widget.info != 'Завершен' ? 0 : (currentView ? MediaQuery.of(context).size.width / 15 : MediaQuery.of(context).size.width / 25),
//           ),
//     );
//   }

//   Text realStatus(BuildContext context) {
//     return Text(
//       widget.info == 'Завершен' ? 'Окончен' : '${widget.info}',
//       style: Theme.of(context).textTheme.caption.copyWith(
//             fontSize: currentView ? MediaQuery.of(context).size.width / 20 : MediaQuery.of(context).size.width/25,
//             color: Colors.indigo[600],
//           ),
//     );
//   }
// }
