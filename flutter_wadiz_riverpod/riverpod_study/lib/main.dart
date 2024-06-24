import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/provider/counter_consumerwidget.dart';
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
          child: CounterStatefulWidget(),
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

//Stateful: 기본적인 상태관리를 위한 위젯
//ConsumerStatefulWidget: provider 패키지와 함께 사용해 상태를 관리하는 위젯

class CounterStatefulWidget extends ConsumerStatefulWidget {
  const CounterStatefulWidget({super.key});

  @override
  ConsumerState<CounterStatefulWidget> createState() =>
      _CounterStatefulWidgetState();
}

class _CounterStatefulWidgetState extends ConsumerState<CounterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final counter = ref.read(counterProvider);
        counter.increment();
        setState(() {});
      },
      child: Text("증가시키기 ${ref.read(counterProvider).counterValue}"),
    );
  }
}
