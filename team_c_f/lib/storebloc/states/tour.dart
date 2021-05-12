import 'package:team_c_f/data/data.dart';

class TourState {
  final int name; // цифровой

  TourState({required this.name});

  TourState copyWith({
    int? name,
  }) =>
      TourState.all(
        name: name ?? this.name,
      );

  TourState.all({
    required this.name
  });
}
