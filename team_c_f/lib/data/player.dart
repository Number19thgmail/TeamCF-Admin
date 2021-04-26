class Player {
  String? docId;
  final String uid;
  final String name;
  late List<int?> points = [];

  Player({required this.uid, required this.name, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Name': name,
      'Points': points,
    };
  }
}
