class MeetData {
  final String round;
  final List<String> team;
  final DateTime date;
  final List<int> score;
  final bool started;

  MeetData({
    required this.round,
    required this.team,
    required this.date,
    required this.score,
    required this.started,
  });

  factory MeetData.fromMap({required Map<String, dynamic> data}) {
    return MeetData(
      round: data['Round'],
      team: data['Team'],
      date: data['Date'],
      score: data['Score'],
      started: data['Started'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
      'Team': team,
      'Date': date,
      'Score': score,
      'Started': started,
    };
  }
}
