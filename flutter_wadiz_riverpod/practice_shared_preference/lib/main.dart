import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPref = await SharedPreferences.getInstance();
  // await sharedPref.setString("test", "1");
  // final testValue = sharedPref.getString("test");
  // print(testValue);

  // await sharedPref.setInt("test_int", 100);
  // final testIntValue = sharedPref.getInt("test_int");
  // print(testIntValue);

  runApp(ProviderScope(overrides: [
    sharedPreferenceProvider.overrideWithValue(sharedPref),
  ], child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return Text(
                      '${ref.read(sharedPreferenceProvider).getInt("test_int")}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
