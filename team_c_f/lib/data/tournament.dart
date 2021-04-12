import 'package:flutter/material.dart';
import 'package:team_c_f/data/currenttour.dart';
import 'package:team_c_f/data/forecast.dart';
import 'package:team_c_f/data/player.dart';
import 'package:team_c_f/data/schedule.dart';
import 'package:team_c_f/data/team.dart';
import 'package:team_c_f/servise/operationdb.dart';

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
  List<Forecast> forecast = []; // Прогнозы тура, который просматривается

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
        schedule = value;
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
    tour != '' ?
    DatabaseService().getForecasts(tour: tour).then((value) {
      forecast = value;
      selectTour = tour;

      notifyListeners();
    })
    : selectTour = '';
    notifyListeners();
  }
}
