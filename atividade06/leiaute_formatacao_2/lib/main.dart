// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildContainerPrimary(Colors.red),
              buildContainerSecondary(Colors.yellow, Color.fromARGB(255, 98, 139, 31)),
              buildContainerPrimary(Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainerPrimary(Color color) {
    return Container(
      width: 100,
      color: color,
    );
  }

  Container buildContainerSecondary(Color colorOne, Color colorTwo) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            color: colorOne
          ),
          Container(
            width: 100,
            height: 100,
            color: colorTwo
          ),
        ]
      ),
    );
  }
}
