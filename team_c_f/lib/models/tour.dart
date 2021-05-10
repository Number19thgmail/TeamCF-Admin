class TourData {
  final String round;
  String? name;
  late List<List<String>> team;
  TourData({required this.round, this.name});

  String get stage => name?? round;

  TourData.all({
    required this.round,
    required this.team,
  });

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
      'Team': team.map((List<String> match) => match.first + '><' + match.last).toList(),
      'Name': name ?? round,
    };
  }

  factory TourData.fromMap({required Map<String, dynamic> data}) {
    TourData t = TourData(round: data['Round'], name: data['Name']);
    List<String> match = data['Team'].cast<String>();
    t.team = match.map((String pair) => pair.split('><').toList()).toList();
    return t;
  }
}
