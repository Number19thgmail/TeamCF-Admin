import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;

class ShowTable extends StatelessWidget {
  // Класс, отображающий туры, с возможностью их выбора для просмотра
  const ShowTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Турнирная таблица'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Click'),
          ),
        ],
      ),
    );
  }
}
