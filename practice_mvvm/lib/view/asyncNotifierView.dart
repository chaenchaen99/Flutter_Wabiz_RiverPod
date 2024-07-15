import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_mvvm/view_model/post_vm.dart';

class Asyncnotifierview extends StatelessWidget {
  const Asyncnotifierview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Consumer(
        builder: (context, ref, child) {
          final posts = ref.watch(fetchPostsProvider);
          return switch (posts) {
            AsyncData(:final value) => ListView.builder(
                itemCount: value?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${value?[index].id}"),
                    subtitle: Text("${value?[index].title}"),
                  );
                }),
            AsyncData(:final error) => Text("$error"),
            _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              )
          };
        },
      )),
    );
  }
}
