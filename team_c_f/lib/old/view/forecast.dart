import 'package:flutter/material.dart';

class MakeForecast extends StatelessWidget { // Класс, позволяющий сделать прогноз на следующий тур
  const MakeForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Прогноз на ближайший тур'),
    );
  }
}
