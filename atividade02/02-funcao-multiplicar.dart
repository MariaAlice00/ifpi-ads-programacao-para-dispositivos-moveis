/* Crie uma função que receba um array e retorne a multiplicação de todos os elementos; */

void main() {
  List array = [1, 2, 3, 4, 5];
  var res = multiplicar(array);

  print("Multiplicação: $res");
}

multiplicar(array) {
  return array.reduce((num1, num2) => num1 * num2);
}