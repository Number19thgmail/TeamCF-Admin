import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/old/data/currenttour.dart';
import 'package:team_c_f/old/data/forecast.dart';
import 'package:team_c_f/old/data/player.dart';
import 'package:team_c_f/old/data/push.dart';
import 'package:team_c_f/old/data/schedule.dart';
import 'package:team_c_f/old/data/shortmatch.dart';
import 'package:team_c_f/old/data/team.dart';
import 'package:team_c_f/old/servise/operationdb.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Tournament with ChangeNotifier {
  // Класс хранящий актуальную информацию с сервера
  late List<Team> allTeams = []; // Все команды
  late CurrentTour current; // Информацию о текущем туре
  late List<Tour> schedule = []; // Расписание
  late List<Forecast> currentForecasts = []; // Прогнозы на текущий тур
  late List<Player> allPlayers = []; // Все игроки
  late Player me; // Текущий игрок
  late Team? myTeam; // Моя команда
  late String selectTour = ''; // Тур для просмотра
  // bool leaveForecastForSelectedTour =
  //     false; // Оставлен ли прогноз на текущий тур

  Tournament() {
    // Конструктор
    Stream<CurrentTour> streamCurrentTour = DatabaseService().getCurrentTour();
    streamCurrentTour.listen(
      (CurrentTour currentTour) {
        current = currentTour;

        Stream<List<Forecast>> streamCurrentForecast =
            DatabaseService().getCurrentForecasts(stage: current.tour!);
        streamCurrentForecast.listen(
          (List<Forecast> forecasts) {
            currentForecasts = forecasts;
            notifyListeners();
          },
        );
      },
    );

    DatabaseService().getAllPlayers().then(
      (List<Player> players) {
        allPlayers = players;
        DatabaseService().getAllTeam().then(
          (List<Team> teams) {
            allTeams = teams;
            initMeAndMyTeam(uid: me.uid);
            notifyListeners();
          },
        );
      },
    );

    DatabaseService().getAllTour().then(
      (value) {
        List<Tour> curr = [];
        curr = [...value.where((element) => element.tour.length < 2)];
        curr.sort((a, b) => a.tour[0].compareTo(b.tour[0]));
        schedule = [...curr];

        curr = [...value.where((element) => element.tour.length == 2)];
        curr.sort((a, b) => a.tour[1].compareTo(b.tour[1]));
        curr.sort((a, b) => a.tour[0].compareTo(b.tour[0]));
        schedule.addAll([...curr]);

        curr = [
          ...value.where(
              (element) => element.tour.length > 2 && element.tour.length < 11)
        ];
        curr.sort((a, b) => a.tour[4].compareTo(b.tour[4]));
        curr.sort((a, b) => b.tour[2].compareTo(a.tour[2]));
        schedule.addAll([...curr]);

        curr = [...value.where((element) => element.tour.length == 12)];
        curr.sort((a, b) => a.tour[6].compareTo(b.tour[6]));
        schedule.addAll([...curr]);

        notifyListeners();
      },
    );
  }

  Future<bool> checkForecast({required String stage}) async {
    return DatabaseService().checkForecast(uid: me.uid, stage: stage);
  }

  List<String> get allTeamNames {
    // Получение всех неполных команд для списка при регистрации
    return allTeams.isNotEmpty
        ? allTeams
            .where((team) => team.members.length < 3)
            .map((team) => team.title)
            .toList()
        : [];
  }

  void initMeAndMyTeam({required String uid}) {
    // Инициализация для более быстрой работы
    if (allPlayers.isNotEmpty)
      me = allPlayers.where((player) => player.uid == uid).single;
    myTeam = allTeams.isNotEmpty && me.team != ''
        ? allTeams.where((team) => team.title == me.team).single
        : null;
  }

  Future registrationPlayer({
    // Регистрация игрока
    @required uid,
    @required capitan,
    @required name,
    @required team,
  }) async {
    if (await DatabaseService().userExists(userId: uid)) {
      me.team = team;
      me.confirmed = capitan;
      me.capitan = capitan;
      DatabaseService().updatePlayer(player: me);
    } else {
      Player p = Player(
        name: name,
        capitan: capitan,
        team: team,
        uid: uid,
        confirmed: capitan,
      );
      DatabaseService()
          .registrationPlayer(player: p)
          .whenComplete(() => notifyListeners());
    }
  }

  void registrationTeam({
    // Регистрация команды
    @required title,
  }) {
    Team t = Team(title: title, members: [me.uid]);
    allTeams.add(t);
    DatabaseService().registrationTeam(team: t);
    myTeam = t;

    notifyListeners();
  }

  void confirmPlayer({required String uid, required bool confirm}) {
    // Подтверждение игрока и доабвление его в команду
    Player p = allPlayers.where((player) => player.uid == uid).single;
    Team t = allTeams.where((team) => team.title == p.team).single;
    p.confirmed = confirm;
    confirm ? t.members.add(uid) : p.team = '';
    DatabaseService().updateTeam(team: t);
    DatabaseService().updatePlayer(player: p);
  }

  void removePlayerFromMyTeam({required String uid}) {
    // Удаление игрока из команды и обнуление команды у игрока
    Player p = allPlayers.where((player) => player.uid == uid).first;
    Team t = allTeams.where((team) => team.title == p.team).first;
    p.confirmed = false;
    p.team = '';
    t.members.remove(p.uid);
    DatabaseService().updateTeam(team: t);
    DatabaseService().updatePlayer(player: p);
  }

  void createSchedule({required List<Tour> tours}) {
    //Создание расписания
    tours.forEach(
      (tour) {
        Tour t = Tour.basic(tour: tour.tour, pair: tour.pair);
        schedule.add(t);
        DatabaseService().addTour(tour: t);
      },
    );
    notifyListeners();
  }

  void select(String tour) {
    // Выбор тура или обнуление его
    tour != '' ? selectTour = tour : selectTour = '';
    notifyListeners();
  }

  Future<Tour> getTour({required String tour}) async {
    // Получение информации о туре
    Tour t = await DatabaseService().getTour(stage: tour).first;
    schedule.setAll(
        schedule.indexWhere((element) => element.docId == t.docId), [t]);
    return t;
  }

  Future<bool> makeForecast({required Forecast forecast}) {
    return DatabaseService().makeForecast(forecast: forecast).then(
          (response) => DatabaseService()
              .checkForecast(uid: me.uid, stage: forecast.tour),
        );
  }

  Future<Forecast> getCurrentForecast({required String stage}) {
    return DatabaseService().getForecast(uid: me.uid, tour: stage);
  }

  void createMatchesForTour(
      {required List<ShortMatch> matches, String? stage}) {
    // Добавление матчей для прогнозирования на сервер
    Tour t = schedule.where((tour) => tour.tour == stage).single;
    matches.sort(
      (a, b) => DateTime.parse('${a.date} ${a.time}').compareTo(
        DateTime.parse('${b.date} ${b.time}'),
      ),
    );
    t.matches = matches;
    t.deadline =
        DateTime.parse('${t.matches.first.date} ${t.matches.first.time}')
            .add(Duration(hours: -1));
    t.ending = DateTime.parse('${t.matches.last.date} ${t.matches.last.time}')
        .add(Duration(hours: 3));
    Fluttertoast.showToast(
        msg: 'Дедлайн в ${DateFormat('MM.dd HH.mm').format(t.deadline)}\n' +
            'Окончание тура в ${DateFormat('MM.dd HH.mm').format(t.ending)}');
    DatabaseService().updateTour(tour: t);

    Uri url = Uri.parse('https://onesignal.com/api/v1/notifications');
    Map<String, String> headers = {};
    headers['authorization'] =
        'Basic ODkyZTdlNDUtM2Y0Yy00MDQ0LThjYmMtY2MxMzljMzQ1YzQ5';
    headers['Content-Type'] = 'application/json; charset=utf-8';
    String notifyNow = Push(
      enTitle: 'New tour',
      enContent:
          'You can leave a forecast for ${!stage!.contains(' ') ? '$stage round' : stage}',
      ruTitle: 'Новый тур',
      ruContent:
          'Можно оставить прогноз на ${!stage.contains(' ') ? '$stage тур' : '$stage'}',
    ).toJson();
    String notifyDayToDeadline = Push(
      enTitle: 'Less than a day before the deadline',
      enContent:
          'Be in time by ${DateFormat('HH:mm').format(t.deadline)} tomorrow',
      ruTitle: 'Менее суток до дедлайна',
      ruContent: 'Успей до завтра до ${DateFormat('HH:mm').format(t.deadline)}',
      date: t.deadline.add(Duration(days: -1)),
    ).toJson();
    String notifyHourToDeadline = Push(
      enTitle: 'Less than an hour to deadline',
      enContent: 'Be in time before ${DateFormat('HH:mm').format(t.deadline)}',
      ruTitle: 'До дедлайна менее часа',
      ruContent: 'Успей до ${DateFormat('HH:mm').format(t.deadline)}',
      date: t.deadline.add(Duration(hours: -1)),
    ).toJson();
    String notifyDeadline = Push(
      enTitle: 'Acceptance of forecasts is closed',
      enContent:
          'Go to the app to see the predictions of your team and the opposing team',
      ruTitle: 'Приём прогнозов закрыт',
      ruContent:
          'Зайти в приложение посмотреть прогнозы своей команды и команды соперников',
      date: t.deadline,
    ).toJson();
    String notifyTourIsEnd = Push(
      enTitle: 'Tour completed',
      enContent: 'Summing up',
      ruTitle: 'Тур завершён',
      ruContent: 'Подводим итоги',
      date: t.ending,
    ).toJson();

    http.post(url, headers: headers, body: notifyNow);
    http.post(url, headers: headers, body: notifyDayToDeadline);
    http.post(url, headers: headers, body: notifyHourToDeadline);
    http.post(url, headers: headers, body: notifyDeadline);
    http.post(url, headers: headers, body: notifyTourIsEnd);
  }
}
