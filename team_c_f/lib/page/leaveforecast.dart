import 'package:flutter/material.dart';

class LeaveForecast extends StatelessWidget {
  final String stage;
  const LeaveForecast({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз на ' +
            '${!stage.contains(' ') ? '$stage тур' : '$stage'}'),
      ),
      body: Center(
        child: TextButton(
          child: Text('POP'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
