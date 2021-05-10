import 'package:team_c_f/data/data.dart';
import 'package:team_c_f/models/player.dart';

class UnconfirmedPlayerModel {
  final String uid;
  late String name;
  UnconfirmedPlayerModel({required this.uid}) {
    name = Data.players.where((PlayerData p) => p.uid == uid).single.name;
  }
}
