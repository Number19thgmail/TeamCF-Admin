import 'package:flutter/material.dart' as material;
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:team_c_f/data/shortmatch.dart';

String getProb({String body}) {
  Map<String, List<Element>> data = Map<String, List<Element>>();
  Document doc = parse(body);
  Element element = doc.getElementsByClassName('match-center').first;
  element = element.getElementsByTagName('li').first;
  List<Element> curr =
      element.getElementsByClassName('light-gray-title corners-3px');
  curr.removeAt(0);
  List<String> tournamentName =
      curr.map((e) => e.getElementsByTagName('a').first.text).toList();

  curr = element.getElementsByClassName('stat onlines-box');
  curr.removeAt(0);
  int i = 0;
  curr.forEach((element) {
    data[tournamentName[i++]] = element.getElementsByTagName('tr');
  });
  String s = '';
  data.forEach((key, value) {
    value.forEach((element) {
      s += element.getElementsByClassName('alLeft gray-text').first.text +
          ' ' +
          element
              .getElementsByClassName('owner-td')
              .first
              .text
              .replaceAll('\n', '') +
          ' ' +
          element
              .getElementsByClassName('guests-td')
              .first
              .text
              .replaceAll('\n', '') +
          '\n';
    });
  });
  return s;
}

List<ShortMatch> getMatchs({
  @material.required String body,
  @material.required String date,
}) {
  List<ShortMatch> m = [];
  Map<String, List<Element>> data = Map<String, List<Element>>();
  Document doc = parse(body);
  Element element = doc.getElementsByClassName('match-center').first;
  element = element.getElementsByTagName('li').first;
  List<Element> curr =
      element.getElementsByClassName('light-gray-title corners-3px');
  curr.removeAt(0);
  List<String> tournamentName =
      curr.map((e) => e.getElementsByTagName('a').first.text).toList();

  curr = element.getElementsByClassName('stat onlines-box');
  curr.removeAt(0);
  int i = 0;
  curr.forEach((element) {
    data[tournamentName[i++]] = element.getElementsByTagName('tr');
  });

  data.forEach((key, value) {
    value.forEach((element) {
      String time =
          element.getElementsByClassName('alLeft gray-text').first.text;
      String away = element
          .getElementsByClassName('owner-td')
          .first
          .text
          .replaceAll('\n', '');
      String home = element
          .getElementsByClassName('guests-td')
          .first
          .text
          .replaceAll('\n', '');
      m.add(ShortMatch(
          home: home, away: away, time: time, date: date, tournament: key));
    });
  });
  return m;
}
