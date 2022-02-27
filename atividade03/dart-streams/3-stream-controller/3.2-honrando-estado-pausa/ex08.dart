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
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;

  void tick(_) {
    counter++;
    controller.add(counter); // Peça ao stream para enviar valores de contador como evento.
    if (counter == maxCount) {
      timer?.cancel();
      controller.close(); // Peça ao stream para desligar e diga aos listeners.
    }
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer);

  return controller.stream;
}