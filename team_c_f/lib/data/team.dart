class Team {
  late String docId;
  final String name;
  final String uidCapitan;
  List<String> players = [];

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

  factory Team.fromMap(Map<String, dynamic> map) {
    Team t = Team(
      name: map['Name'] as String,
      uidCapitan: map['Capitan'],
    );
    t.players = [...map['Players']];
    return t;
  }
}
