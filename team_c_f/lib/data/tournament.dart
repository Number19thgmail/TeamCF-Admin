import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/shortmatch.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/operationdb.dart';
import 'package:team_c_f/data/match.dart';
import 'package:intl/intl.dart';

class Tournament with ChangeNotifier {
  // Класс хранящий актуальную информацию с сервера
  List<Team> allTeams = []; // Все команды
  CurrentTour current; // Информацию о текущем туре
  List<Tour> schedule = []; // Расписание
  List<Forecast> currentForecasts = []; // Прогнозы на текущий тур
  List<Player> allPlayers = []; // Все игроки
  Player me; // Текущий игрок
  Team myTeam; // Моя команда
  String selectTour = ''; // Тур для просмотра

  Tournament() {
    // Конструктор
    DatabaseService().getAllTeam().then(
      (value) {
        allTeams = value;
        notifyListeners();
      },
    );
    DatabaseService().getCurrentTour().then(
      (value) {
        current = value;
        notifyListeners();
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

        // schedule.sort((a, b) => a.tour.length.compareTo(b.tour.length));
        notifyListeners();
      },
    );
    DatabaseService().getCurrentForecasts().then(
      (value) {
        currentForecasts = value;
        notifyListeners();
      },
    );
    DatabaseService().getAllPlayers().then(
      (value) {
        allPlayers = value;
        notifyListeners();
      },
    );
  }

  List<String> get allTeamNames {
    // Получение всех неполных команд для списка при регистрации
    return allTeams.isNotEmpty
        ? allTeams
            .where((t) => t.members.length < 3)
            .map((t) => t.title)
            .toList()
        : [];
  }

  void initMeAndMyTeam({@required String uid}) {
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
      allPlayers.add(p);
      me = p;
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

  void confirmPlayer({@required String uid, @required bool confirm}) {
    // Подтверждение игрока и доабвление его в команду
    Player p = allPlayers.where((player) => player.uid == uid).single;
    Team t = allTeams.where((team) => team.title == p.team).single;
    p.confirmed = confirm;
    confirm ? t.members.add(uid) : p.team = '';
    DatabaseService().updatePlayer(player: p);
    DatabaseService().updateTeam(team: t);

    notifyListeners();
  }

  void removePlayerFromMyTeam({@required String uid}) {
    // Удаление игрока из команды и обнуление команды у игрока
    Player p = allPlayers.where((player) => player.uid == uid).first;
    Team t = allTeams.where((team) => team.title == p.team).first;
    p.confirmed = false;
    p.team = '';
    t.members.remove(p.uid);
    DatabaseService().updatePlayer(player: p);
    DatabaseService().updateTeam(team: t);

    notifyListeners();
  }

  void createSchedule({@required List<Tour> tours}) {
    //Создание расписания
    tours.forEach(
      (tour) {
        Tour t = Tour.basic(tour: tour.tour, pair: tour.pair);
        schedule.add(t);
        DatabaseService().addTour(tour: t);
      },
    );
    //schedule.add(Tour.basic(tour: tour, pair: pair));

    notifyListeners();
  }

  void select(String tour) {
    // Выбор тура или обнуление его
    tour != '' ? selectTour = tour : selectTour = '';
    notifyListeners();
  }

  Future<Tour> getTour({@required String tour}) {
    // Получение информации о туре
    return DatabaseService().getTour(tour: tour).then((Tour value) => value);
  }

  void createMatchesForTour(
      {@required List<ShortMatch> matches, String stage}) {
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
    t.ending =
        DateTime.parse('${t.matches.last.date} ${t.matches.last.time}')
            .add(Duration(hours: 3));
    Fluttertoast.showToast(
        msg: 'Дедлайн в ${DateFormat('MM.dd HH.mm').format(t.deadline)}\n' +
        'Окончание тура в ${DateFormat('MM.dd HH.mm').format(t.ending)}');
    DatabaseService().updateTour(tour: t);
  }
}
