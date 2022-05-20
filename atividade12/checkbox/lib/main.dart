import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Checkbox';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
