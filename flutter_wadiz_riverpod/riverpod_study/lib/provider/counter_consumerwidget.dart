//Consumer Widget: 상태 변경을 듣고 상태에 의존하는 위젯 트리의 일부만 다시 빌드하도록 설계
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/provider/counter_provider.dart';

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider);
    return ElevatedButton(
      onPressed: () {
        counter.increment();
      },
      child: const Text(
        "증가시키기",
      ),
    );
  }
}
