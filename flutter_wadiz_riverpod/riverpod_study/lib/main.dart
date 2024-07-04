import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/change_notifier_provider/my_change_notifier_provider.dart';
import 'package:riverpod_study/stream_provider/simple_stream_provider.dart';

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
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: MyStreamProviderWidget()),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final count = ref.watch(counterChangeNotifierProvider).counterValue;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("카운터 값: $count"),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(counterChangeNotifierProvider.notifier)
                        .increment();
                  },
                  child: const Text("증가"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(counterChangeNotifierProvider.notifier)
                        .decrement();
                  },
                  child: const Text("감소"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
