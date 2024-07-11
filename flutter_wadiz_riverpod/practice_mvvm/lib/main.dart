import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_mvvm/model/post_model.dart';
import 'package:practice_mvvm/view_model/post_vm.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Consumer(
        builder: (context, ref, child) {
          final posts = ref.watch(asyncPostsGenNotifierProvider);
          return posts.when(data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${data[index].id}"),
                    subtitle: Text("${data[index].title}"),
                  );
                });
          }, error: (error, trace) {
            return Text("$error");
          }, loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          });
        },
      )),
    );
  }
}
