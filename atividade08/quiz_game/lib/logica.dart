import 'questao.dart';

class QuizLogica {
  int _questaoNumero = 0;

  final List<Questao> _questoes = [
    Questao('Brasília é a capital do Brasil', true),
    Questao('O Oceano Pacífico é o segundo maior do mundo', false),
    Questao('A China é o país mais populoso do mundo', true),
    Questao('O Coliseu é uma das Sete Maravilhas do Mundo Moderno', true),
    Questao('A capital dos EUA é Nova York', false)
  ];

  String obterQuestao() {
    return _questoes[_questaoNumero].questaoString;
  }

  bool estaFinalizado() {
    if (_questaoNumero >= _questoes.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void resetar() {
    _questaoNumero = 0;
  }

  bool obterResposta() {
    return _questoes[_questaoNumero].questaoResposta;
  }

  void proximaQuestao() {
    if (_questaoNumero < _questoes.length - 1) {
      _questaoNumero++;
    }
  }
}