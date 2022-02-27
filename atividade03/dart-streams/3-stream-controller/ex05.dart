import 'dart:async';

void main() {
  // NOTA: Esta implementação é FALHA!
  // Começa antes de ter assinantes e não implementa pausa.
  Stream<int> timedCounter(Duration interval, [int? maxCount]) {
    var controller = StreamController<int>();
    int counter = 0;
    void tick(Timer timer) {
      counter++;
      controller.add(counter); // Peça ao stream para enviar valores de contador como evento.
      if (maxCount != null && counter >= maxCount) {
        timer.cancel();
        controller.close(); // BAD: Começa antes de ter assinantes.
      }
    }

    Timer.periodic(interval, tick); 
    return controller.stream;
  }

    var counterStream = timedCounter(const Duration(seconds: 1), 6);
    counterStream.listen(print); // Imprima um inteiro a cada segundo, 6 vezes.

}