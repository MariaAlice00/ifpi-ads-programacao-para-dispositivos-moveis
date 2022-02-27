void main() {
  var counterStream =
  Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(8);

  // Para visualizar os eventos
  // Dobre o número inteiro em cada evento.
  var doubleCounterStream = counterStream.map((int x) => x * 2);

  doubleCounterStream.forEach(print);
}