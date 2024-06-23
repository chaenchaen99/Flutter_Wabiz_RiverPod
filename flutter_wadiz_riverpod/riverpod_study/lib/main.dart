import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/provider/counter_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      //Provider Container를 가지고있다.
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Hello World!'),
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            final counter = ref.read(counterProvider);
            return FloatingActionButton(
              onPressed: () {
                counter.increment();
              },
              child: const Icon(
                Icons.add,
              ),
            );
          },
        ),
      ),
    );
  }
}
