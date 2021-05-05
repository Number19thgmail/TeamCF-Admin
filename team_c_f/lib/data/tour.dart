class TourData {
  final String round;
  String? name;
  late List<List<String>> team; // проверить порядок
  TourData({required this.round, this.name});

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
      'Team': team,
      'Name': name == null ? round : name,
    };
  }

  factory TourData.fromMap({required Map<String, dynamic> data}) {
    TourData t = TourData(round: data['Round'], name: data['Name']);
    t.team = data['Team'];
    return t;
  }
}
