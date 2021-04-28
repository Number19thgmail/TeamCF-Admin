class CurrentTour {
  String round;
  CurrentTour({required this.round});

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
    };
  }

  factory CurrentTour.fromMap({required Map<String, dynamic> data}){
    return CurrentTour(round: data['Round']);
  }
}
