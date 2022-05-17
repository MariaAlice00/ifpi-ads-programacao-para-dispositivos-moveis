// ignore_for_file: prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Font Style',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Font Style'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> _selections = List.generate(3, (_) => false);
  bool bold = false;
  bool italic = false;
  bool underline = false;

  String textFormat = 'Maria Alice';

  void format(int index) {
    setState(() {
      for (int i = 0; i < _selections.length; i++) {
        if (index == 0) {
          bold = !bold;
        } else if (index == 1) {
          italic = !italic;
        } else if (index == 2) {
          underline = !underline;
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                textFormat,
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  decoration: underline ? TextDecoration.underline : TextDecoration.none),
              ),
            ),
            Container(
              child: ToggleButtons(
                children: <Widget>[
                  Icon(Icons.format_bold),
                  Icon(Icons.format_italic),
                  Icon(Icons.format_underline),
                ],
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    _selections[index] = !_selections[index];
                    format(index);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
