import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_c_f/models/choicemeet.dart';
import 'package:team_c_f/storebloc/states/selectmeets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class SelectMeetsEvent {
  final String? key;
  final List<DateTime>? range;
  final ChoiceMeetData? meet;
  final bool? choice;
  final Event event;

  SelectMeetsEvent({
    this.choice,
    this.key,
    this.range,
    this.meet,
    required this.event,
  });
}

enum Event {
  changeRange,
  selectMeet,
  changeDateState,
  changeTournamentState,
}

class SelectMeetsBloc extends Bloc<SelectMeetsEvent, SelectMeetsState> {
  SelectMeetsBloc(SelectMeetsState initialState) : super(initialState);

  @override
  Stream<SelectMeetsState> mapEventToState(SelectMeetsEvent event) async* {
    switch (event.event) {
      case Event.changeRange:
        if (event.range != null) {
          List<DateTime> range = [];
          Map<String, Map<String, List<ChoiceMeetData>>> allMeets = {};
          Map<String, bool> openDate = {};
          Map<String, bool> openTournament = {};
          for (DateTime i = event.range!.first;
              i.isBefore(event.range!.last);
              i = i.add(
            Duration(days: 1),
          ),) {
            Map<String, List<ChoiceMeetData>> map = {};
            range.add(i);
            String date = DateFormat('yyyy-MM-dd').format(i);
            openDate.addAll({date: false});
            Document doc = parse((await Client().get(
                    Uri.parse('https://www.sports.ru/football/match/$date/')))
                .body);
            Element element = doc.getElementsByClassName('match-center').single;
            element = element.getElementsByTagName('li').first;
            List<Element> divs = [...element.children];
            divs.removeWhere((Element el) =>
                el.innerHtml.contains('Реклама') ||
                el.innerHtml.contains('Матч дня'));
            String tournament = '';
            for (int index = 0; index < divs.length; index++) {
              if (index.isEven) {
                tournament = divs[index].text.replaceAll('\n', '');
                openTournament.addAll({date + tournament: false});
              } else {
                map[tournament] = [
                  ...divs[index].getElementsByTagName('tr').map(
                        (Element meet) => ChoiceMeetData.fromHtml(
                          html: meet,
                          date: date,
                        ),
                      )
                ];
              }
            }
            allMeets[date] = map;
          }
          yield state.copyWith(
            dateRange: range,
            allMeets: allMeets,
            openDate: openDate,
            openTornament: openTournament,
          );
        }
        break;
      case Event.selectMeet:
        if (event.meet != null) {
          state.allMeets.forEach(
            (date, value) {
              value.forEach(
                (tournament, list) {
                  list.where((element) => element == event.meet).
                  forEach(
                    (sel) {
                      sel.selected = event.choice!;
                    },
                  );
                },
              );
            },
          );
          if (event.choice!)
            state.selectedMeets.add(
              event.meet!,
            );
          else
            state.selectedMeets.removeWhere(
              (element) => element == event.meet!,
            );
          yield state.copyWith(
            allMeets: state.allMeets,
            selectedMeets: state.selectedMeets,
          );
        }
        break;
      case Event.changeDateState:
        if (event.key != null) {
          state.openDate[event.key!] = !state.openDate[event.key]!;
          yield state.copyWith(openDate: state.openDate);
        }
        break;
      case Event.changeTournamentState:
        if (event.key != null) {
          state.openTornament[event.key!] = !state.openTornament[event.key]!;
          yield state.copyWith(openTornament: state.openTornament);
        }
        break;
    }
  }
}
