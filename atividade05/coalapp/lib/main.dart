// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 199, 170),
      appBar: AppBar(
        title: Text('I Am Poor'),
        backgroundColor: Color.fromARGB(255, 28, 70, 30),
      ),
      body: Center(
        child: Image(
          image: AssetImage('images/coal.png'),
          ),
        ),
    ),
  ));
}
