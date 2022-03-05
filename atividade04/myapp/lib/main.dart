import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Primeira App'),
        ),
        body: Center(
          child: Text(
            'Hello World :)',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold)
              ),
        ),
      )
    );
  }
}
