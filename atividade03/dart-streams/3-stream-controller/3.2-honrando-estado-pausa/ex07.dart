import 'dart:async';

void main() async {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  late StreamSubscription<int> subscription;

  subscription = counterStream.listen((int counter) {
    print(counter); // Imprime um inteiro a cada segundo.
    if (counter == 5) {
      // Após 5 tiques, faça uma pausa por cinco segundos e, em seguida, retome.
      subscription.pause(Future.delayed(const Duration(seconds: 5)));
    }
  });
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
