import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/future_provider/simple_future_provider.dart';
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
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyFutureProviderWidget(),
    );
  }
}

class MyFutureProviderWidget extends ConsumerWidget {
  const MyFutureProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intValue = ref.watch(simpleIntFutureProvider);
    return intValue.when(data: (data) {
      return Center(child: Text("$data"));
    }, error: (error, trace) {
      return Center(child: Text("$error"));
    }, loading: () {
      return const Center(child: Text("로딩중"));
    });
  }
}
