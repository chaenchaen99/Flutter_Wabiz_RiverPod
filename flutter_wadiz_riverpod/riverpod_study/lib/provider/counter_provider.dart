import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter {
  int counterValue = 0;

  increment() {
    counterValue++;
    print(counterValue);
  }
}

class Counter2 {
  int counterValue = 1;

  increment() {
    counterValue++;
  }
}

final counterProvider = Provider<Counter>(
  (ref) => Counter(),
);

final counter2Provider = Provider(
  (ref) => Counter2(),
);
