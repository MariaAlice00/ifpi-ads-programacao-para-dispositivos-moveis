// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_logica.dart';

QuizLogica quizLogic = QuizLogica();

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
          title: Text(
            'Quiz Game',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Widget> pontuacao = [];

  int totalCorretas = 0;
  int totalQuestoes = 0;

  void checarResposta(bool value) {
    if (quizLogic.obterResposta() == value) {
      print('resposta certa');
      pontuacao.add(
        Icon(
          Icons.check, 
          color: Color.fromARGB(255, 109, 226, 113)
        )
      );
      totalCorretas++;
    } 
    else {
      print('resposta errada');
      pontuacao.add(
        Icon(
          Icons.close, 
          color: Color.fromARGB(255, 212, 83, 73)
        )
      );
    }

    totalQuestoes++;

    if (quizLogic.estaFinalizado() == true) {
      Alert(
          context: context,
          title: 'Finalizado',
          desc: 'Você acertou $totalCorretas de $totalQuestoes questões!',
          buttons: [
            DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Jogar Novamente',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ))
          ]).show();

      quizLogic.resetar();
      pontuacao.clear();

      totalCorretas = 0;
      totalQuestoes = 0;
    } 
    else {
      quizLogic.proximaQuestao();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.purple[200],
                ),
                child: Center(
                  child: Text(
                    quizLogic.obterQuestao(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              )),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    textColor: Colors.white,
                    color: Colors.greenAccent[400],
                    child: Text(
                      'VERDADEIRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checarResposta(true);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    textColor: Colors.white,
                    color: Colors.redAccent[400],
                    child: Text(
                      'FALSO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checarResposta(false);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: pontuacao,
          ),
        )
      ],
    );
  }
}