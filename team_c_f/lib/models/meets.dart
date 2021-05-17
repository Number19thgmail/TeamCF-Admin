import 'meet.dart';

class MeetsData {
  late String uid;
  final int round;
  final List<MeetData> meets;
  final String deadline;
  final bool started;

  MeetsData({
    required this.round,
    required this.meets,
    required this.deadline,
    required this.started,
  });

  factory MeetsData.fromMap(
      {required Map<String, dynamic> data, required String uid}) {
    List<MeetData> a = [];
    if (data['Meets'].isNotEmpty)
      a.addAll(
        [
          ...data['Meets']
              .map(
                (meet) => MeetData.fromString(data: meet),
              )
              .toList(),
        ],
      );
    MeetsData meets = MeetsData(
      round: data['Round'],
      meets: a,
      deadline: data['Deadline'],
      started: data['Started'],
    );
    meets.uid = uid;
    return meets;
  }

  Map<String, dynamic> toMap() {
    return {
      'Round': round,
      'Meets': meets.map((e) => e.toString()).toList(),
      'Deadline': deadline,
      'Started': started,
    };
  }
}
