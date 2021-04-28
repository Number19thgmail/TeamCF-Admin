class Team {
  late String docId;
  final String name;
  final String uidCapitan;
  List<String> players = [];

  late int maxTour;
  late int goals;
  late int missed;
  late int win;
  late int draw;
  late int lose;
  int get points => win * 3 + draw;
  late int position;

  Team({required this.name, required this.uidCapitan}) {
    players.add(this.uidCapitan);
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Capitan': uidCapitan,
      'Players': players,
    };
  }

  factory Team.fromMap({required Map<String, dynamic> data}) {
    Team t = Team(
      name: data['Name'] as String,
      uidCapitan: data['Capitan'],
    );
    t.players = [...data['Players']];
    return t;
  }
}
