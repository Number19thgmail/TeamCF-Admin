import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_c_f/models/forecast.dart';
import 'package:team_c_f/models/meets.dart';

class TourService {
  final CollectionReference _forecastsCollection =
      FirebaseFirestore.instance.collection('forecasts');
  final CollectionReference _meetsCollection =
      FirebaseFirestore.instance.collection('meets');

  void leaveForecast({required ForecastData forecast}) {
    _forecastsCollection.add(forecast.toMap());
  }

  void updateForecast({required ForecastData forecast}) {
    _forecastsCollection.doc(forecast.docId).update(forecast.toMap());
  }

  Future<ForecastData?> getForecast({required String uid, required int round}) {
    return _forecastsCollection
        .where('Round', isEqualTo: round)
        .where('UserId', isEqualTo: uid)
        .get()
        .then(
          (QuerySnapshot response) => response.docs.length == 1
              ? ForecastData.fromMap(
                  data: response.docs.single.data(),
                  docId: response.docs.single.id,
                )
              : null,
        );
  }

  Future<bool> enableTour({required int round}) {
    return _meetsCollection
        .where('Round', isEqualTo: round)
        .get()
        .then((QuerySnapshot response) => !MeetsData.fromMap(
              data: response.docs.single.data(),
              docId: response.docs.single.id,
            ).started);
  }

  Future closeForecasting({required int round}) async {
    QueryDocumentSnapshot doc =
        (await _meetsCollection.where('Round', isEqualTo: round).get())
            .docs
            .single;
    MeetsData meets = MeetsData.fromMap(data: doc.data(), docId: doc.id);
    meets.started = true;
    _meetsCollection.doc(doc.id).update(meets.toMap());
  }
}
