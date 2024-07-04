import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/stream_provider/simple_stream_provider.dart';

class MyStreamProviderWidget extends ConsumerWidget {
  const MyStreamProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(simpleStreamProvider);
    return switch (counter) {
      AsyncData(:final value) => Text("$value"),
      AsyncError(:final error) => Text("$error"),
      _ => const Text("로딩중"),
    };
    // return counter.when( // counter라는 변수의 상태에 따라 위젯을 렌더링
    //   data: (data) => Center(
    //     child: Text("$data"),
    //   ),
    //   error: (error, trace) {
    //     return Center(
    //       child: Text("$error"),
    //     );
    //   },
    //   loading: () => const Center(
    //     child: Text("로딩중"),
    //   ),
    // );
  }
}
