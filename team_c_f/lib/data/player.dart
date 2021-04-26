class Player {
  late String docId;
  final String uid;
  final String name;
  late List<int?> points = [];

  Player({required this.uid, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Name': name,
      'Points': points,
    };
  }
}
