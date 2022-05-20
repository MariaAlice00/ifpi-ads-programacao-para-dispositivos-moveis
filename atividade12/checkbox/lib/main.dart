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
      title: 'Checkbox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Checkbox'),
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
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Lorem ipsum dolor sit amet. Aut sint voluptatem vel quos numquam nam reiciendis autem. At voluptas amet non commodi nulla cum omnis facere. Qui voluptatibus autem sed eveniet aperiam eos cumque reiciendis. A error perferendis ut aspernatur provident id internos ducimus. Et beatae inventore in veritatis aspernatur aut reiciendis vero in fugit porro.',
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ),
          Container(
            child: Column(
               children: <Widget>[
                 ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
                        if (isChecked1 && isChecked2 && isChecked3) {
                          isChecked4 = true;
                        } else {
                          isChecked4 = false;
                        }
                      });
                    },
                  ),
                  title: const Text('Permito utilizar meu número de celular'),
                ),
                ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                        if (isChecked1 && isChecked2 && isChecked3) {
                          isChecked4 = true;
                        } else {
                          isChecked4 = false;
                        }
                      });
                    },
                  ),
                  title: const Text('Permito utilizar o aúdio do sistema'),
                ),
                ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked3 = value!;
                        if (isChecked1 && isChecked2 && isChecked3) {
                          isChecked4 = true;
                        } else {
                          isChecked4 = false;
                        }
                      });
                    },
                  ),
                  title: const Text('Aceito compartilhar dados para melhoria do aplicativo'),
                ),
                ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: isChecked4,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked4 = value!;
                        if (isChecked4) {
                          isChecked1 = true;
                          isChecked2 = true;
                          isChecked3 = true;
                        } else {
                          isChecked1 = false;
                          isChecked2 = false;
                          isChecked3 = false;
                        }
                      });
                    },
                  ),
                  title: const Text('Aceitar todos os itens acima'),
                ),
              ]
            )
          )
        ]
      )
    );
  }
}
