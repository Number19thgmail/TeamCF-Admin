import 'package:html/dom.dart';
import 'package:intl/intl.dart';

class ChoiceMeetData {
  final List<String> team;
  final DateTime date;
  late bool selected;

  ChoiceMeetData({
    required this.team,
    required this.date,
    required this.selected,
  });

  factory ChoiceMeetData.fromHtml({
    required String date,
    required Element html,
  }) {
    List<String> team = [
      html.getElementsByClassName('owner-td').single.text.replaceAll(
            '\n',
            '',
          ),
      html.getElementsByClassName('guests-td').single.text.replaceAll(
            '\n',
            '',
          ),
    ];
    String time = html.getElementsByClassName('alLeft gray-text').first.text;
    time = date + ' ' + (time != '—' ? time : '00:00');
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(time);
    bool selected = false;
    return ChoiceMeetData(
      team: team,
      date: dateTime,
      selected: selected,
    );
  }

  ChoiceMeetData copyWith({required bool selected}) {
    return ChoiceMeetData(
      team: this.team,
      date: this.date,
      selected: selected,
    );
  }
}
