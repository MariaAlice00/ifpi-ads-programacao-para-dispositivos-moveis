import 'Diretor.dart';
import 'Gerente.dart';

void main() {
  Gerente g = new Gerente(5000, 120000, 2);
  Diretor d = new Diretor(10000, 120000, 5);

  print(g.getBonificacao());
  print(d.getBonificacao());
}