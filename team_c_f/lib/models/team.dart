class TeamData {
  late String docId;
  final String name;
  final String uidCapitan;
  List<String> players = [];
  List<int?> goal = [];

  int get maxTour => goal.fold(
      0,
      (value, current) => current != null
          ? current > value
              ? current
              : value
          : value);
  int get goals => goal.fold(
        0,
        (value, current) => value + (current != null ? current : 0),
      );
  int missed = 0;
  int win = 0;
  int draw = 0;
  int lose = 0;
  int get points => win * 3 + draw;
  late int prevPosition;

  TeamData({required this.name, required this.uidCapitan}) {
    players.add(this.uidCapitan);
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Capitan': uidCapitan,
      'Players': players,
      'Goal': goal,
    };
  }

  factory TeamData.fromMap({required Map<String, dynamic> data}) {
    TeamData t = TeamData(
      name: data['Name'] as String,
      uidCapitan: data['Capitan'],
    );
    t.players = [...data['Players']];
    t.goal = [...data['Goal']];
    return t;
  }
}
