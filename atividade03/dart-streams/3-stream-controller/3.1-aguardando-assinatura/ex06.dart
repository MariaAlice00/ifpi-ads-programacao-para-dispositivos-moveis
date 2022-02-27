import 'dart:async';

void main() async {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  await Future.delayed(const Duration(seconds: 5));

  // Após 5 segundos, adicione um listener.
  await for (final n in counterStream) {
    print(n); // Imprima um inteiro a cada segundo, 15 vezes.
  }
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) {
  var controller = StreamController<int>();
  int counter = 0;
  void tick(Timer timer) {
    counter++;
    controller.add(
        counter); // Peça ao stream para enviar valores de contador como evento.
    if (maxCount != null && counter >= maxCount) {
      timer.cancel();
      controller.close(); 
    }
  }

  Timer.periodic(interval, tick);
  return controller.stream;
}
