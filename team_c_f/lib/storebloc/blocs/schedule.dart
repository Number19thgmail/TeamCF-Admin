import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/states/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

class ScheduleEvent {
  final String? stage;
  final Event event;

  ScheduleEvent({this.stage, required this.event});
}

enum Event {
  createSuccessful,
  selectTour,
  unselectTour,
}

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState);

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    switch (event.event) {
      case Event.createSuccessful:
        yield state.copyWith(
          tours: Data.tours
              .map(
                (TourData tour) => TourModel(tour: tour),
              )
              .toList(),
        );
        break;
      case Event.selectTour:
        if (event.stage != null) {
          yield state.copyWith(nameTour: event.stage, tourSelected: true);
        }
        break;
      case Event.unselectTour:
        yield state.copyWith(tourSelected: false);
        break;
    }
  }
}
