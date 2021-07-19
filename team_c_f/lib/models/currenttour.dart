class CurrentTourData {
  late String docId;
  int round;
  CurrentTourData({required this.round});

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
    };
  }

  factory CurrentTourData.fromMap({required Map<String, dynamic> data, required String docId}){
    CurrentTourData curr = CurrentTourData(round: data['Round']);
    curr.docId = docId;
    return curr;
  }
}
