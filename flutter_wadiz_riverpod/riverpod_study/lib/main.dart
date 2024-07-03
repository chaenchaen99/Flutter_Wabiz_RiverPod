import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          return StreamBuilder(
            //StreamBuilder는 주어진 스트림을 구독하고, 스트림의 데이터나 상태가 변경될 때마다 UI를 빌드
            stream: ref.watch(simpleStreamProvider.future).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text("${snapshot.data}"),
                );
              }
              return const Text("로딩중");
            },
          );
        },
      ),
    );
  }
}

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
