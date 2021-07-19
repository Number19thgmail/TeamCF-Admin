import 'package:team_c_f/models/choicemeet.dart';

class SelectMeetsState {
  List<DateTime> dateRange = [];
  Map<String, Map<String, List<ChoiceMeetData>>> allMeets = {};
  Map<String, bool> openDate = {};
  Map<String, bool> openTornament = {};
  List<ChoiceMeetData> selectedMeets = [];

  SelectMeetsState();

  SelectMeetsState copyWith({
    List<DateTime>? dateRange,
    Map<String, Map<String, List<ChoiceMeetData>>>? allMeets,
    Map<String, bool>? openDate,
    Map<String, bool>? openTornament,
    List<ChoiceMeetData>? selectedMeets,
  }) =>
      SelectMeetsState.all(
        dateRange: dateRange ?? this.dateRange,
        allMeets: allMeets ?? this.allMeets,
        openDate: openDate ?? this.openDate,
        openTornament: openTornament ?? this.openTornament,
        selectedMeets: selectedMeets ?? this.selectedMeets,
      );

  SelectMeetsState.all({
    required this.dateRange,
    required this.allMeets,
    required this.openDate,
    required this.openTornament,
    required this.selectedMeets,
  });
}
