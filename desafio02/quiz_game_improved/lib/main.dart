// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'logica.dart';


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

  final List<Widget> listaPontuacao = [];
  int score = 0;

  int totalCorretas = 0;
  int totalQuestoes = 0;

  void checarResposta(bool value) {
    if (quizLogic.obterResposta() == value) {
      print('resposta certa');
      listaPontuacao.add(
        Icon(
          Icons.check, 
          color: Colors.green
        )
      );
      totalCorretas++;
      score++;
    } 
    else {
      print('resposta errada');
      listaPontuacao.add(
        Icon(
          Icons.close, 
          color: Colors.red
        )
      );
    }

    totalQuestoes++;

    if (quizLogic.estaFinalizado() == true) {
      double porcentagem = (100 * totalCorretas) / totalQuestoes;

      Alert(
          context: context,
          title: 'Finalizado',
          desc: 'Você acertou $totalCorretas de $totalQuestoes questões! \n $porcentagem %',
          buttons: [
            DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Jogar Novamente',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ))
          ]).show();

      quizLogic.resetar();
      listaPontuacao.clear();

      totalCorretas = 0;
      totalQuestoes = 0;

      score = 0;
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
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                ),
                child: Center(
                  child: Text(
                    'Pontuação: $score',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ),
        ),
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
                    color: Colors.green,
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
                    color: Colors.red,
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
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    textColor: Colors.white,
                    color: Colors.grey,
                    child: Text(
                      'TALVEZ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      print('aperte verdadeiro ou falso!');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: listaPontuacao,
          ),
        )
      ],
    );
  }
}