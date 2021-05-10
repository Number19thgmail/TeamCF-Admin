import 'package:team_c_f/models/tour.dart';

class TourModel{
  late String name;
  final TourData tour;


  TourModel({required this.tour}){
    name = tour.name ?? tour.round;
  }
}