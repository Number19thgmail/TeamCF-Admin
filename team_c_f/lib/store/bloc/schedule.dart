import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/servises/schedule.dart';
import 'package:team_c_f/store/components/schedule.dart';
import 'package:team_c_f/store/components/unconfirmedplayer.dart';

enum ScheduleEvent {
  createSchedule
} //confirmedPlayer, unconfirmedPlayer, reset }

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(ScheduleState initialState) : super(initialState);

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    switch (event) {
      case ScheduleEvent.createSchedule:
        yield state;
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
