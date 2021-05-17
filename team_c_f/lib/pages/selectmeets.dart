import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/models/choicemeet.dart';
import 'package:team_c_f/models/meet.dart';
import 'package:team_c_f/models/meets.dart';
import 'package:team_c_f/servises/selectmeets.dart';
import 'package:team_c_f/servises/servises.dart';
import 'package:team_c_f/storebloc/blocs/selectmeets.dart';
import 'package:team_c_f/storebloc/blocs/tour.dart' as tourBloc;
import 'package:team_c_f/storebloc/states/selectmeets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';

class SelectMeetsPage extends StatelessWidget {
  final int round;
  const SelectMeetsPage({Key? key, required this.round}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SelectMeetsBloc bloc = SelectMeetsBloc(SelectMeetsState());
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) => Container(
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        RangePicker(
                          selectedPeriod: DatePeriod(
                            bloc.state.dateRange.isNotEmpty
                                ? bloc.state.dateRange.first
                                : DateTime.now().add(
                                    Duration(days: 3),
                                  ),
                            bloc.state.dateRange.isNotEmpty
                                ? bloc.state.dateRange.last
                                : DateTime.now().add(
                                    Duration(days: 4),
                                  ),
                          ),
                          firstDate: DateTime.now().add(
                            Duration(days: 2),
                          ),
                          lastDate: DateTime(2099),
                          onChanged: (DatePeriod period) {
                            bloc.add(
                              SelectMeetsEvent(
                                event: Event.changeRange,
                                range: [period.start, period.end],
                              ),
                            );
                          },
                        ),
                        ...bloc.state.allMeets.keys.map((String date) {
                          int countDate = bloc.state.allMeets[date]!.values
                              .map(
                                (list) => list
                                    .where((element) => element.selected)
                                    .length,
                              )
                              .reduce((value, element) => value + element);
                          return Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  bloc.add(
                                    SelectMeetsEvent(
                                      event: Event.changeDateState,
                                      key: date,
                                    ),
                                  );
                                },
                                child: Text(
                                  date + showSelectIn(countDate),
                                ),
                              ),
                              if (bloc.state.openDate[date]!)
                                ...bloc.state.allMeets[date]!.keys.map(
                                  (String tournament) {
                                    int countTournament = bloc
                                        .state.allMeets[date]![tournament]!
                                        .where((element) => element.selected)
                                        .length;
                                    return Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            bloc.add(
                                              SelectMeetsEvent(
                                                event:
                                                    Event.changeTournamentState,
                                                key: date + tournament,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            tournament +
                                                showSelectIn(
                                                  countTournament,
                                                ),
                                          ),
                                        ),
                                        if (bloc.state
                                            .openTornament[date + tournament]!)
                                          ...bloc.state
                                              .allMeets[date]![tournament]!
                                              .map(
                                            (ChoiceMeetData meetData) {
                                              return Card(
                                                child: CheckboxListTile(
                                                  value: meetData.selected,
                                                  onChanged: (bool? a) {
                                                    bloc.add(
                                                      SelectMeetsEvent(
                                                        event: Event.selectMeet,
                                                        meet: meetData,
                                                        choice: a,
                                                      ),
                                                    );
                                                  },
                                                  title: Text(DateFormat(
                                                              'HH:mm ')
                                                          .format(
                                                              meetData.date) +
                                                      meetData.team.first +
                                                      ' - ' +
                                                      meetData.team.last),
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    );
                                  },
                                ).toList(),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: bloc.state.selectedMeets.length == 10
                          ? () {
                              bloc.state.selectedMeets
                                  .sort((a, b) => a.date.compareTo(b.date));
                              List<String> team = [];
                              bloc.state.selectedMeets.forEach(
                                (ChoiceMeetData meet) {
                                  team.addAll(meet.team);
                                },
                              );
                              SelectMeetsService().cteateMeet(
                                meet: MeetsData(
                                  round: round,
                                  meets: bloc.state.selectedMeets
                                      .map(
                                        (ChoiceMeetData choiceMeetData) =>
                                            MeetData(
                                          date: DateFormat('yyyy-MM-dd HH:mm')
                                              .format(choiceMeetData.date),
                                          score: [0, 0],
                                          started: false,
                                          team: [
                                            choiceMeetData.team.first,
                                            choiceMeetData.team.last
                                          ],
                                          status: 'Не начат',
                                        ),
                                      )
                                      .toList(),
                                  deadline:
                                      DateFormat('yyyy-MM-dd HH:mm').format(
                                    bloc.state.selectedMeets[0].date.add(
                                      Duration(hours: -1),
                                    ),
                                  ),
                                  started: false,
                                ),
                                // MeetsData(
                                //   round: round,
                                //   team: team,
                                //   date: DateFormat('yyyy-MM-dd HH:mm').format(
                                //     bloc.state.selectedMeets[0].date.add(
                                //       Duration(hours: -1),
                                //     ),
                                //   ),
                                //   score: [],
                                //   started: false,
                                // ),
                              );
                              Navigator.pop(
                                context,
                                tourBloc.TourEvent(
                                  event: tourBloc.Event.selectMeets,
                                ),
                              );
                            }
                          : null,
                      child: Text('Выбрано ${bloc.state.selectedMeets.length}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
