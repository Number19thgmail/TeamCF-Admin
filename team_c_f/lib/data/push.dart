import 'package:flutter/material.dart';

class Push {
  final String enTitle;
  final String ruTitle;
  final String enContent;
  final String ruContent;

  Push({
    @required this.enTitle,
    @required this.ruTitle,
    @required this.enContent,
    @required this.ruContent,
  });

  String toMap(){
    return '{"app_id": "93b27d54-e442-4af5-86e4-a215faf20e3a",'+
    '"headings" : {"en": "$enTitle", "ru": "$ruTitle"},'+
    '"contents": {"en": "$enContent", "ru": "$ruContent"},'+
    '"included_segments": ["Subscribed Users"]}';
  }
}
