import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_mvc/controller.dart';
import 'package:flutter_architecture_mvc/model.dart';

// TODO: MVC 패턴을 적용하여 카운터 앱이 동작하도록 변경하기
// - 단, View 내에 변수는 없어야 한다. (ex. counter)

class CounterView extends StatefulWidget {
  final CounterController counterController;
  final CounterModeController counterModeController;

  const CounterView(
      {super.key,
      required this.counterController,
      required this.counterModeController});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('MVC'),
        actions: [
          IconButton(
            onPressed: onChangeMode,
            icon: const Icon(CupertinoIcons.arrow_2_squarepath),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              widget.counterController.counter.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: execute,
        child: Icon(widget.counterModeController.counterMode.icon),
      ),
    );
  }

  void onChangeMode() {
    setState(() {
      widget.counterModeController.toggleMode();
    });
  }

  void execute() {
    setState(() {
      switch (widget.counterModeController.counterMode) {
        case CounterMode.plus:
          widget.counterController.increment();
        case CounterMode.minus:
          widget.counterController.decrement();
      }
    });
  }
}

extension on CounterMode {
  IconData get icon {
    switch (this) {
      case CounterMode.plus:
        return CupertinoIcons.add;
      case CounterMode.minus:
        return CupertinoIcons.minus;
    }
  }
}
