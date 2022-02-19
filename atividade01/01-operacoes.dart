import 'dart:math';

String inteiro(n1) {
  if (n1 is int) {
    return 'É inteiro';
  } else {
    return 'Não é inteiro';
  }
}

void main() {
  var n1 = 10;
  var n2 = 3;

  print(n1 % n2);
  print(n1 ~/ n2);
  print(pow(n1, n2));
  print(inteiro(n1));
}
