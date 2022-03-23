// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

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
  int _numero = 1;
  Color _iconColor = Colors.grey;

  void _mudaNumero(int valor) {
    setState(() {
      _numero += valor;
    });

    if (_numero <= 1) {
      _numero = 1;
    } else if (_numero >= 3) {
      _numero = 3;
    }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent,
                ),
                child: Text('<-'),
                onPressed: () {
                  _mudaNumero(-1);
                },
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent,
                ),
                child: Text('->'),
                onPressed: () {
                  _mudaNumero(1);
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/imagem$_numero.jpg'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Imagem $_numero',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                child: Text('LIKE'),
                onPressed: () {
                  print('Like na imagem $_numero');
                },
              ),
              IconButton(
                  icon: Icon(Icons.favorite, color: _iconColor),
                  onPressed: () {
                    setState(() {
                      _iconColor = Colors.red;
                    });
                  }
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
