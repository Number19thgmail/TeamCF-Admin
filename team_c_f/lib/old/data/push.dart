import 'package:intl/intl.dart';

class Push {
  final String enTitle;
  final String ruTitle;
  final String enContent;
  final String ruContent;
  final DateTime? date;

  Push({
    required this.enTitle,
    required this.ruTitle,
    required this.enContent,
    required this.ruContent,
    this.date,
  });

  String toJson() {
    String lateSend = (date != null)
        ? '"send_after": "${DateFormat('yyyy-MM-dd HH:mm:ss').format(date!)}",'
        : '';
    return '{"app_id": "93b27d54-e442-4af5-86e4-a215faf20e3a",' +
        '"headings" : {"en": "$enTitle", "ru": "$ruTitle"},' +
        '"contents": {"en": "$enContent", "ru": "$ruContent"},' +
        lateSend +
        '"included_segments": ["Subscribed Users"]}';
  }
}
