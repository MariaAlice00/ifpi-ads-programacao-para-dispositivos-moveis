import 'dart:async';

void main() {
  Timer.periodic(const Duration(seconds: 1), (timer) => print('timer'));
  
  print('end of main');
}