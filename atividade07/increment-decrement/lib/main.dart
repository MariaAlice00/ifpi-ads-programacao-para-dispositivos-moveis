// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Contador',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _numero = 0;

  void _mudaNumero(int valor) {
    setState(() {
      _numero += valor;

      if (_numero <= 0) {
        _numero = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Contador: $_numero',
              style: TextStyle(fontSize: 22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onSurface: Colors.green,
                    elevation: 20,
                    shadowColor: Colors.red,
                  ),
                  child: Text('+1'),
                  onPressed: () {
                    _mudaNumero(1);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onSurface: Colors.green,
                    elevation: 20,
                    shadowColor: Colors.red,
                  ),
                  child: Text('-1'),
                  onPressed: () {
                    _mudaNumero(-1);
                  },
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
