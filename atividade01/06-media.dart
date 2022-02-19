String resultado(a, b, c) {
  double media = (a + b + c) / 3;
  if (media >= 7) {
    return 'aprovado';
  } else if (media < 4) {
    return 'reprovado';
  } else {
    return 'de exame final';
  }
}

void main() {
  double notaUm = 8.6;
  double notaDois = 7.5;
  double notaTres = 5.8;

  final String res = resultado(notaUm, notaDois, notaTres);

  print('Você está ${res}');
}
