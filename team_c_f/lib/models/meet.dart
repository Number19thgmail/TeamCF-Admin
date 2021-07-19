class MeetData {
  final List<String> team;
  final String date;
  late List<int> score;
  final bool started;
  late String status;

  MeetData({
    required this.team,
    required this.date,
    required this.score,
    required this.started,
    required this.status,
  });

  factory MeetData.fromMap({required Map<String, dynamic> data}) {
    return MeetData(
      team: data['Team'].cast<String>(),
      date: data['Date'],
      score: data['Score'].cast<int>(),
      started: data['Started'],
      status: data['Status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Team': team,
      'Date': date,
      'Score': score,
      'Started': started,
      'Status': status,
    };
  }

  String toString() {
    return '${team.first} - ${team.last}|$date|${score.first}:${score.last}|$started|$status';
  }

  factory MeetData.fromString({required String data}) {
    List<String> split = data.split('|');
    return MeetData(
      team: split[0].split(' - '),
      date: split[1],
      score: split[2].split(':').map((String goal) => int.parse(goal)).toList(),
      started: bool.fromEnvironment(split[3]),
      status: split[4],
    );
  }
}
