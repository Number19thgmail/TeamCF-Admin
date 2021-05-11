import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/servises/createschedule.dart';
import 'package:team_c_f/servises/servises.dart';
import 'package:team_c_f/storebloc/states/createschedule.dart';

enum CreateScheduleEvent { changeCircle, createSchedule }

class CreateScheduleBloc
    extends Bloc<CreateScheduleEvent, CreateScheduleState> {
  CreateScheduleBloc(CreateScheduleState initialState) : super(initialState);

  @override
  Stream<CreateScheduleState> mapEventToState(
      CreateScheduleEvent event) async* {
    switch (event) {
      case CreateScheduleEvent.changeCircle:
        yield state.copyWith(circle: state.circle);
        break;
      case CreateScheduleEvent.createSchedule:
        Data.tours = createSchedule(state.circle);
        CreateScheduleService().create();
        yield state;
        break;
    }
  }
}
