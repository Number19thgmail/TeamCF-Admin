import 'package:team_c_f/data/data.dart';

class TourState {
  final String name; // цифровой

  TourState({required this.name});

  TourState copyWith({
    String? name,
  }) =>
      TourState.all(
        name: name ?? this.name,
      );

  TourState.all({
    required this.name
  });
}
