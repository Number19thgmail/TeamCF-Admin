import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/forecast.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/models/player.dart';
import 'package:team_c_f/pages/leaveforecast.dart';
import 'package:team_c_f/pages/selectmeets.dart';
import 'package:team_c_f/servises/tour.dart';
import 'package:team_c_f/store/login/login.dart';
import 'package:team_c_f/storebloc/blocs/leaveforecast.dart' as leave;
import 'package:team_c_f/storebloc/blocs/schedule.dart' as schedule;
import 'package:team_c_f/storebloc/blocs/tour.dart';
import 'package:team_c_f/storebloc/models/leaveforecast.dart';
import 'package:team_c_f/storebloc/states/leaveforecast.dart';
import 'package:team_c_f/storebloc/states/tour.dart';
import 'package:team_c_f/views/meets.dart';
import 'package:team_c_f/views/tour.dart';

class TourPage extends StatelessWidget {
  final bool back;
  const TourPage({Key? key, required this.back}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TourBloc bloc = back
        ? context.watch<schedule.ScheduleBloc>().state.tourBloc!
        : context.watch<TourBloc>();
    return BlocBuilder<TourBloc, TourState>(
      bloc: bloc,
      builder: (context, state) => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              back
                  ? TextButton(
                      onPressed: () {
                        context.read<schedule.ScheduleBloc>().add(
                              schedule.ScheduleEvent(
                                  event: schedule.Event.unselectTour),
                            );
                      },
                      child: Text(
                        'Назад',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Card(
                      color: Colors.yellow[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                bloc.add(
                                    TourEvent(event: Event.showListAbsense));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Список неявок',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            state.size
                                ? Container(
                                    child: Column(
                                      children: [
                                        ...Data.players
                                            .where(
                                                (player) => player.team != '')
                                            .where((player) => Data.names.every(
                                                (leave) => leave != player.uid))
                                            .map(
                                              (player) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(player.name),
                                              ),
                                            ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Матчи ${state.tour.name} ${state.tour.name.length < 3 ? 'тура' : ''}'),
              ),
              state.meets.meets.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowMeets(
                            meetsModel: state.meets,
                          ),
                        ),
                        if (!state.meets.started)
                          TextButton(
                              onPressed: () async {
                                ForecastData? oldForecast;
                                if (Data.names.isNotEmpty)
                                  oldForecast = await TourService().getForecast(
                                    uid: context.read<Login>().userId,
                                    round: state.round,
                                  );
                                await TourService()
                                        .enableTour(round: state.tour.stage)
                                    ? Navigator.of(context)
                                        .push(
                                        MaterialPageRoute<LeaveForecastState>(
                                          builder: (context) => BlocProvider<
                                              leave.LeaveForecastBloc>(
                                            create: (_) =>
                                                leave.LeaveForecastBloc(
                                              LeaveForecastState(
                                                meetsData: Data.meets
                                                    .where((MeetsData m) =>
                                                        m.round == state.round)
                                                    .single,
                                                forecast: oldForecast,
                                              ),
                                            ),
                                            child: LeaveForecastPage(),
                                          ),
                                        ),
                                      )
                                        .then(
                                        (LeaveForecastState? result) {
                                          if (result != null) {
                                            List<int> rate = [];
                                            PlayerData me = Data.players
                                                .where((PlayerData p) =>
                                                    p.uid ==
                                                    context
                                                        .read<Login>()
                                                        .userId)
                                                .single;
                                            ForecastData forecast =
                                                ForecastData(
                                              uid: me.uid,
                                              team: me.team,
                                              round: result.round,
                                              rate: rate,
                                            );
                                            result.meets.forEach(
                                              (LeaveForecastModel model) {
                                                rate.addAll(
                                                    [model.home, model.away]);
                                              },
                                            );
                                            if (oldForecast != null) {
                                              forecast.docId =
                                                  oldForecast.docId;
                                              TourService().updateForecast(
                                                forecast: forecast,
                                              );
                                            } else
                                              TourService().leaveForecast(
                                                forecast: forecast,
                                              );
                                            bloc.add(
                                              TourEvent(
                                                event: Event.makeForecast,
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    : Fluttertoast.showToast(
                                        msg: 'Приём прогнозов закрыт');
                              },
                              child: Text('Мой прогноз')),
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute<TourEvent?>(
                            builder: (context) =>
                                SelectMeetsPage(round: state.round),
                          ),
                        )
                            .then(
                          (TourEvent? event) {
                            if (event != null) bloc.add(event);
                          },
                        );
                      },
                      child: Text('Выбрать матчи'),
                    ),
              ShowTour(tour: state.tour),
              ElevatedButton(
                onPressed: (){
                  TourService().closeForecasting(round: state.tour.stage);
                },
                child: Text('Закрыть приём прогнозов'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
