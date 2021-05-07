class CurrentTourData {
  String round;
  CurrentTourData({required this.round});

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
    };
  }

  factory CurrentTourData.fromMap({required Map<String, dynamic> data}){
    return CurrentTourData(round: data['Round']);
  }
}
