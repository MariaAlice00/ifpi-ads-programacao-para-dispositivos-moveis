void main() {
  var counterStream =
    Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(8);
    // Para visualizar os eventos
    counterStream.forEach(print); // Imprima um inteiro a cada segundo, 8 vezes.
}