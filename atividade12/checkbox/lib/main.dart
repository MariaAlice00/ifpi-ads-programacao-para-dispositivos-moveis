import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final itens = <Map>[
    {"nome": "Item 1", "check": false},
    {"nome": "Item 2", "check": false},
    {"nome": "Item 3", "check": false},
    {"nome": "Item 4", "check": false},
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(itens[index]["nome"]),
          subtitle: Text(
            "Este item ${itens[index]["check"] ? "" : "não"} está selecionado",
          ),
          value: itens[index]["check"],
          onChanged: (newValue) {
            setState(() {
              itens[index]["check"] = newValue;
            });
          },
        );
      },
    );
  }
}
