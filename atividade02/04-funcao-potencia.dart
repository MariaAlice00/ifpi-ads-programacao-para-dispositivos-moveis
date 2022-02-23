/* Crie duas versões de uma função que eleva um número (base) a outro (expoente): a primeira versão é a tradicional, já a segunda deve ser uma arrow function. */

import 'dart:math';

void main() {
  var base = 10;
  var expoente = 2;

  print('Resultado da função tradicional = ${potenciaFuncaoTradicional(base, expoente)}');
  print('Resultado da arrow function = ${potenciaArrowFunction(base, expoente)}');
}

potenciaFuncaoTradicional(base, expoente) {
  return pow(base, expoente);
}

var potenciaArrowFunction = (int base, int expoente) => pow(base, expoente);
