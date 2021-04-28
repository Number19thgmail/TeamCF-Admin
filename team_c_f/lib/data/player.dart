class Player {
  String? docId;
  final String uid;
  final String name;
  final String? team;
  late List<int?> points = [];

  int? get maxTour => points.reduce((f, s) => f! < s! ? s : f);
  late int goals;
  late int position;
  //     максимум забитых за тур (инт),
  //     количество забитых за все матчи (инт),
  //     позиция (инт).

  Player(
      {required this.uid, required this.name, required this.team, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Name': name,
      'Team': team,
      'Points': points,
    };
  }

  factory Player.fromMap({required Map<String, dynamic> data}) {
    Player p = Player(
      name: data['Name'],
      team: data['Team'],
      uid: data['UserId'],
    );
    p.points = [...data['Points']];
    return p;
  }
}
