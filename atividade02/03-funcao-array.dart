/* Crie uma função que receba um array e uma das funções com a sintaxe acima e as execute. Faça um exemplo para ambas; */

import '01-funcao-soma.dart';
import '02-funcao-multiplicar.dart';

void main() {
  List arrayUm = [1, 2, 3];
  List arrayDois = [1, 2, 4];

  var resSoma = arrayFuncaoSomar(arrayUm, somar);
  var resMultiplicacao = arrayFuncaoMultiplicar(arrayDois, multiplicar);

  print(resSoma);
  print(resMultiplicacao);
}

arrayFuncaoSomar(List array, Function somar) {
  return somar(array);
}

arrayFuncaoMultiplicar(List array, Function multiplicar) {
  return multiplicar(array);
}
