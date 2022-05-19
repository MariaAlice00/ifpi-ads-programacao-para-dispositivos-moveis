import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Focus'),
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
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }
    
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
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
            fillColor: MaterialStateProperty.resolveWith(getColor),
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
            fillColor: MaterialStateProperty.resolveWith(getColor),
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
            tristate: false,
            fillColor: MaterialStateProperty.resolveWith(getColor),
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
      ],
    );
  }
}
