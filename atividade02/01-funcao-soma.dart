/* 1. Crie uma função que receba um array e retorne a soma de todos os elementos. */

void main() {
  List array = [1, 2, 3, 4, 5.8];
  var res = somar(array);

  print("Soma: $res");
}

somar(array) {
  return array.reduce((num1, num2) => num1 + num2);
}