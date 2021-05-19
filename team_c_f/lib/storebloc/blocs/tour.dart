import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/storebloc/states/tour.dart';

class TourEvent {
  int? stage;
  final Event event;

  TourEvent({this.stage, required this.event});
}

enum Event {
  showListAbsense,
  makeForecast,
  selectMeets,
  selectTour,
}

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc(TourState initialState) : super(initialState);

  @override
  Stream<TourState> mapEventToState(TourEvent event) async* {
    switch (event.event) {
      case Event.showListAbsense:
        yield state.copyWith(size: !state.size);
        break;
      case Event.makeForecast:
        yield state.copyWith();
        break;
      case Event.selectMeets:
        Data().refreshData();
        yield state.copyWith(round: state.round);
        break;
      case Event.selectTour:
        if (event.stage != null) {
          yield state.copyWith(
            round: event.stage,
            // meetsData: Data.meets
            //     .where((element) => element.round == event.stage)
            //     .single,
          );
        }
        break;
    }
  }
}
