class Player {
  String? docId;
  final String uid;
  final String name;
  final String? team;
  late List<int?> points = [];

  Player({required this.uid, required this.name, required this.team, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Name': name,
      'Team': team,
      'Points': points,
    };
  }
}
