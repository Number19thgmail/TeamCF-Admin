import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/components/oneteam.dart';
import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/tour.dart';
import 'package:team_c_f/storebloc/blocs/leaveforecast.dart';
import 'package:team_c_f/storebloc/models/leaveforecast.dart';
import 'package:team_c_f/storebloc/states/leaveforecast.dart';

class LeaveForecastPage extends StatelessWidget {
  //final MeetsData meetsData;
  LeaveForecastPage({
    Key? key,
    //required this.meetsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveForecastBloc, LeaveForecastState>(
      bloc: context.watch<LeaveForecastBloc>(),
      builder: (context, state) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Прогноз на ' +
                  Data.tours
                      .where((TourData t) => t.round == state.round)
                      .single
                      .name! +
                  ((Data.tours
                              .where((TourData t) => t.round == state.round)
                              .single
                              .name!
                              .length) <
                          3
                      ? ' тур'
                      : ''),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...state.meets
                          .map(
                            (LeaveForecastModel forecast) => OneTeamView(
                              forecast: forecast,
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      state,
                    );
                  },
                  child: Text('Оставить прогноз'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
