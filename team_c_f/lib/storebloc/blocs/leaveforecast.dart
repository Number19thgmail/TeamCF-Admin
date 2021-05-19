import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/storebloc/states/leaveforecast.dart';

class LeaveForecastEvent {
  final bool? position;
  final int? index;
  final int? newValue;
  final Event event;

  LeaveForecastEvent({
    this.position,
    this.index,
    this.newValue,
    required this.event,
  });
}

enum Event {
  changeValue,
}

class LeaveForecastBloc extends Bloc<LeaveForecastEvent, LeaveForecastState> {
  LeaveForecastBloc(LeaveForecastState initialState) : super(initialState);

  @override
  Stream<LeaveForecastState> mapEventToState(LeaveForecastEvent event) async* {
    switch (event.event) {
      case Event.changeValue:
        if (event.index != null &&
            event.newValue != null &&
            event.position != null) {
          if (event.position!)
            state.meets[event.index!].home = event.newValue!;
          else
            state.meets[event.index!].away = event.newValue!;
          yield state.copyWith(meets: state.meets);
        }
        break;
    }
  }
}
