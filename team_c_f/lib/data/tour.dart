class Tour {
  final String round;
  late Map<String, int> team; // проверить порядок
  Tour({required this.round});

  Map<String, dynamic> toMap(){
    return {
      'Round': round,
      'Team': team,
    };
  }

  factory Tour.fromMap({required Map<String, dynamic> data}){
    Tour t = Tour(round: data['Round']);
    t.team = data['Team'];
    return t;
  }
}