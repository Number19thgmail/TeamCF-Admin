class PlayerData {
  String? docId;
  final String uid;
  final String name;
  final String? team;
  late List<int?> points = [];

  int get maxTour => points.fold(
      0,
      (value, current) => current != null
          ? current > value
              ? current
              : value
          : value);
  int get goals => points.fold(
        0,
        (value, current) => value + (current != null ? current : 0),
      );
  late int prevPosition;

  PlayerData({
    required this.uid,
    required this.name,
    required this.team,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Name': name,
      'Team': team,
      'Points': points,
    };
  }

  factory PlayerData.fromMap({required Map<String, dynamic> data}) {
    PlayerData p = PlayerData(
      name: data['Name'],
      team: data['Team'],
      uid: data['UserId'],
    );
    p.points = [...data['Points']];
    return p;
  }
}
