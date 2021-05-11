import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/states/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/storebloc/states/tour.dart';

class TourEvent {
  String? stage;
  final Event event;

  TourEvent({this.stage, required this.event});
}

enum Event {
  makeForecast,
  selectMeets,
  selectTour,
}

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc(TourState initialState) : super(initialState);

  @override
  Stream<TourState> mapEventToState(TourEvent event) async* {
    switch (event.event) {
      case Event.makeForecast:
        yield state;
        break;
      case Event.selectMeets:
        yield state;
        break;
      case Event.selectTour:
        if (event.stage != null) {
          yield state;
        }
        break;
    }
  }
}
