class ForecastData {
  late String docId;
  final String uid;
  final List<int> rate;
  final String? team;
  final int round;
  int result = 0;

  ForecastData({
    required this.uid,
    required this.rate,
    required this.team,
    required this.round,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Rate': rate,
      'Team': team,
      'Round': round,
      'Result': result,
    };
  }

  factory ForecastData.fromMap({required Map<String, dynamic> data, required String docId}) {
    ForecastData f = ForecastData(
      uid: data['UserId'],
      rate: data['Rate'].cast<int>(),
      team: data['Team'],
      round: data['Round'],
    );
    f.result = data['Result'];
    f.docId = docId;
    return f;
  }
}
