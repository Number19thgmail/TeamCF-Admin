class ForecastData {
  final String uid;
  final List<String> rate;
  final String? team;
  final String stage;
  int result = 0;

  // - идентификатор игрока,
  // - лист прогнозов,
  // - название тура,
  // - название команды,
  // - результат.

  ForecastData({
    required this.uid,
    required this.rate,
    required this.team,
    required this.stage,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserId': uid,
      'Rate': rate,
      'Team': team,
      'Stage': stage,
      'Result': result,
    };
  }

  factory ForecastData.fromMap({required Map<String, dynamic> data}) {
    ForecastData f = ForecastData(
      uid: data['UserId'],
      rate: data['Rate'],
      team: data['Team'],
      stage: data['Stage'],
    );
    f.result = data['Result'];
    return f;
  }
}
