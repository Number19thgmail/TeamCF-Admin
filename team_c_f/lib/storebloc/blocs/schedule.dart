import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/models/meet.dart';
import 'package:team_c_f/storebloc/states/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';
import 'package:team_c_f/storebloc/states/tour.dart';

class ScheduleEvent {
  int? round;
  String? uid;
  final Event event;

  ScheduleEvent({required this.event, this.round, this.uid});
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
        state.tourBloc = TourBloc(
          TourState(
            round: event.round!,
            uid: event.uid!,
            // meets: MeetsModel(
            //     meet: Data.meets
            //         .where((MeetsData m) => m.round == event.round)
            //         .single),
          ),
        );
        yield state.copyWith(
          tourSelected: true,
          round: event.round!,
          tourBloc: state.tourBloc,
        );
        break;
      case Event.unselectTour:
        yield state.copyWith(tourSelected: false);
        break;
    }
  }
}
