import 'package:flutter/material.dart';
import 'package:team_c_f/models/info.dart';

class Reglament extends StatelessWidget {
  final InfoData info;
  Reglament({required this.info});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              InkWell(
                child: Icon(Icons.arrow_back, size: 30),
                onTap: () {
                  Navigator.of(context).pop(true);
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              SizedBox(width: 20),
              Text('Правила конкурса'),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              ...info.regulations.map(
                (String item) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(item),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
