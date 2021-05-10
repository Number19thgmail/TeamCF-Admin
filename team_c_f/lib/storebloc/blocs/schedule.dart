import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/components/schedule.dart';
import 'package:team_c_f/storebloc/models/tour.dart';

enum ScheduleEvent {
  createSuccessful
} //confirmedPlayer, unconfirmedPlayer, reset }

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState);

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    switch (event) {
      case ScheduleEvent.createSuccessful:
        yield state.copyWith(
          tours: Data.tours
              .map(
                (TourData tour) => TourModel(tour: tour),
              )
              .toList(),
        );
        break;

      // switch (event) {
      //   case ScheduleEvent.confirmedPlayer: // текущий игрок одобрил заявку
      //     ScheduleService().confirmedPlayer(true, state.selectId);
      //     state.unconfirm.removeWhere(
      //         (UnconfirmedPlayerModel player) => player.uid == state.selectId);
      //     yield state.copyWith(unconfirm: state.unconfirm);
      //     break;
      //   case ScheduleEvent.unconfirmedPlayer: // текущий игрок не одобрил заявку
      //     ScheduleService().confirmedPlayer(false, state.selectId);
      //     if (state.unconfirm
      //         .any((UnconfirmedPlayerModel player) => player.uid == state.selectId))
      //       state.unconfirm.removeWhere(
      //           (UnconfirmedPlayerModel player) => player.uid == state.selectId);
      //     yield state.copyWith(unconfirm: state.unconfirm);
      //     break;
      //   case ScheduleEvent.reset:
      //     yield ScheduleState(uid: state.uid);
      //     break;
    }
  }
}
