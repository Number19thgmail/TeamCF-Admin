import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/servises/myteam.dart';
import 'package:team_c_f/store/components/myteam.dart';
import 'package:team_c_f/store/components/unconfirmedplayer.dart';

enum MyTeamEvent { confirmedPlayer, unconfirmedPlayer, reset }

class MyTeamBloc extends Bloc<MyTeamEvent, MyTeamState> {
  MyTeamBloc(MyTeamState initialState) : super(initialState);

  @override
  Stream<MyTeamState> mapEventToState(MyTeamEvent event) async* {
    switch (event) {
      case MyTeamEvent.confirmedPlayer: // текущий игрок одобрил заявку
        MyTeamService().confirmedPlayer(true, state.selectId);
        state.unconfirm.removeWhere(
            (UnconfirmedPlayerModel player) => player.uid == state.selectId);
        yield state.copyWith(unconfirm: state.unconfirm);
        break;
      case MyTeamEvent.unconfirmedPlayer: // текущий игрок не одобрил заявку
        MyTeamService().confirmedPlayer(false, state.selectId);
        if (state.unconfirm
            .any((UnconfirmedPlayerModel player) => player.uid == state.selectId))
          state.unconfirm.removeWhere(
              (UnconfirmedPlayerModel player) => player.uid == state.selectId);
        yield state.copyWith(unconfirm: state.unconfirm);
        break;
      case MyTeamEvent.reset:
        yield MyTeamState(uid: state.uid);
        break;
    }
  }
}
