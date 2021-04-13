import 'package:flutter/material.dart' as material;
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:team_c_f/data/shortmatch.dart';

List<ShortMatch> getMatchs({
  @material.required String body, // Html-текст страницы
  @material.required String date, // Дата
}) {
  List<ShortMatch> m = [];
  Map<String, List<Element>> data = Map<String, List<Element>>();
  Document doc = parse(body); // Парсинг html в структуру документа
  Element element = doc
      .getElementsByClassName('match-center')
      .first; // Парсинг до нужного тега
  element = element.getElementsByTagName('li').first;
  List<Element> curr =
      element.getElementsByClassName('light-gray-title corners-3px');
  //! Сделать проверку. Если реклама, то удалить
  if (curr[0].innerHtml.contains('Реклама') ||
      curr[0].innerHtml.contains('Матч дня')) curr.removeAt(0);
  if (curr[0].innerHtml.contains('Реклама') ||
      curr[0].innerHtml.contains('Матч дня')) curr.removeAt(0);
  List<String> tournamentName =
      curr.map((e) => e.getElementsByTagName('a').first.text).toList();

  curr = element.getElementsByClassName('stat onlines-box');
  //! Сделать проверку

  if (curr[0].innerHtml.contains('Реклама') ||
      curr[0].innerHtml.contains('Матч дня')) curr.removeAt(0);
  if (curr[0].innerHtml.contains('Реклама') ||
      curr[0].innerHtml.contains('Матч дня')) curr.removeAt(0);
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
