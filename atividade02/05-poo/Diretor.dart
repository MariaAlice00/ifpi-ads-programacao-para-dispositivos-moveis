import 'Funcionario.dart';

class Diretor extends Funcionario {
  late double _salario;
  late double _lucrosEmpresa;
  late double _taxaParticipacao;

  double get salario {
    return _salario;
  }

  set salario(double salario) {
    this._salario = salario;
  }

  double get lucrosEmpresa {
    return _lucrosEmpresa;
  }

  set lucrosEmpresa(double lucrosEmpresa) {
    this._lucrosEmpresa = lucrosEmpresa;
  }

  double get taxaParticipacao {
    return _taxaParticipacao;
  }

  set taxaParticipacao(double taxaParticipacao) {
    this._taxaParticipacao = taxaParticipacao;
  }

  Diretor(this._salario, this._lucrosEmpresa, this._taxaParticipacao);

  @override
  double getBonificacao(){
    return salario + ((taxaParticipacao / 100) * (lucrosEmpresa * 2));
  }
}
