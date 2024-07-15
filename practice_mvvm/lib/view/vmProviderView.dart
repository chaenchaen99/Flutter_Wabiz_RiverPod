import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_mvvm/view_model/post_vm.dart';

class vmProviderView extends StatelessWidget {
  const vmProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Consumer(
        builder: (context, ref, child) {
          final viewModel = ref.read(postViewModelProvider);
          return FutureBuilder(
            future: viewModel.getPosts(),
            builder: (context, snapshow) {
              if (snapshow.hasData) {
                final value = snapshow.data ?? [];
                if (value.isEmpty) {
                  return const Center(
                    child: Text("아이템이 없습니다"),
                  );
                }
                return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${value[index].id}"),
                        subtitle: Text("${value[index].title}"),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          );
        },
      )),
    );
  }
}
