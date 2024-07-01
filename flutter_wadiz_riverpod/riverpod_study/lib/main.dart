import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/provider/counter_cfw.dart';
import 'package:riverpod_study/provider/counter_consumerwidget.dart';
import 'package:riverpod_study/provider/counter_provider.dart';
import 'package:riverpod_study/state_notifier_provider/my_state_notifier_provider.dart';
import 'package:riverpod_study/state_provider/my_state_provider.dart';

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
        body: Consumer(
          builder: ((context, ref, child) {
            final counter = ref.watch(counterStateNotifierProvider);
            return Center(child: Text("$counter"));
          }),
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            return FloatingActionButton(
              onPressed: () {
                ref.read(counterStateNotifierProvider.notifier).increment();
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
