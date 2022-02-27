void main() {
  Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;
      if (i == maxCount) break;
    }
  }

    var counterStream = timedCounter(const Duration(seconds: 1), 6);
    counterStream.listen(print); // Imprima um inteiro a cada segundo, 6 vezes.
}
